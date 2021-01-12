import groovy.util.logging.Log4j2

import com.funnelback.publicui.search.model.transaction.SearchTransaction
import com.funnelback.publicui.search.model.transaction.SearchQuestion.SearchQuestionType
import com.funnelback.publicui.search.model.transaction.facet.FacetDisplayType
import com.funnelback.stencils.hook.support.HookLifecycle
import java.net.URLEncoder

new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)

new SearchPreviewHookLifecycle().postProcess(transaction)
new GroupingResultsHookLifecycle().postProcess(transaction)
new BrowseModeHookLifecycle().postProcess(transaction)
new QueryHookLifecycle().postProcess(transaction)

/**
 * The following functions are used for demo purposes.
 */

// Remove council specific names
transaction?.response?.resultPacket?.results.each() {
	result ->	

	result.title = result.title.replaceAll(/\s+-\s+Camden Council/, "")
	result.title = result.title.replaceAll(/\s*\|\s*SF311/, "")
}


// Add the custom sort to the facet so that
// category letter is sorted in the following format:
// A, B, C ... X, Y, Z, All results,
// Instead of 
// A, All results, B, C ... X, Y, Z
transaction?.response?.facets
	.findAll() {
		facet ->
		// Search for facets which requires 
		facet.name == "Category letter"
	}
	.each() {
		facet ->
		facet.setCustomComparator(new facet.comparator.LabelLengthComparator());
	}
/**
 * <p>Hook functions for provide a preview of a tab powered using extra searches.</p>
 *
 * e.g.
 * Given
 * 	- Two collections:
 *		* events-web
 *		* social-media-custom
 *	- Two exta searches: 
 *	 	* events which queries events-web
 *		* social_media which queries social-media-custom
 *  - Two tab facets:
 *		* "Events" which filters down to documents from events-web
 *		* "Facebook and Twitter" which filters down to documents from events-web
 *
 * The following configuration will:
 *	- Create a preview of the "Events" tab using the events extra search 
 *	- Create a preview of the "Facebook and Twitter" tab using the social_media extra search
 * 
 * stencils.search_preview.events.facet_name=Tabs
 * stencils.search_preview.events.facet_label=Events
 * stencils.search_preview.social_media.facet_name=Tabs
 * stencils.search_preview.social_media.facet_label=Facebook and Twitter
 * 
 * It is also possible to preserve the facet selection when navigating between tabs using the search 
 * preview functionality by using the following option:
 * stencils.search_preview.append_selected_facets=true|false
 *
 */
@Log4j2
class SearchPreviewHookLifecycle implements HookLifecycle {

	/** Key where the preview links will be stored in the custom data map */
	static final String CUSTOM_DATA_NAMESPACE = "stencilsSearchPreviewLink"

	/** Key holding the config */
	static final String CONFIG_KEY_PREFIX = "stencils.search_preview"

	/** Name of the facet or tabs */
	static final String APPEND_SELECTED_FACET_CONFIG = "append_selected_facets"

	/** Name of the facet or tabs */
	static final String FACET_NAME_CONFIG = "facet_name"

    /** The label of the target facet */
	static final String CATEGORY_LABEL_CONFIG = "category_label"

	/** Separator for config keys */
	static final String CONFIG_KEY_SEPARATOR = "."

	/*  Guess type of tabs */
	static final String TAB_GUESSED_DISPLAY_TYPE = "TAB"	

	/**
	 * Updates the data model with "more link" for each extra search.
	 *  
	 * @param transaction
	 */
	void postProcess(SearchTransaction transaction) {
		if (isSearchPreviewEnabled(transaction)) {
			addSearchPreview(transaction)
		}
	}

	/**
	 * Injects the "more link" into each extra search. The "more link"
	 * will provide the user a different way to navigate to a 
     * particular facet or tab
	 *  
	 * @param transaction
	 */
	public void addSearchPreview(def transaction) {

        def profileConfig = transaction.question.getCurrentProfileConfig()

		boolean appendSelectedFacets = profileConfig.get(CONFIG_KEY_PREFIX + CONFIG_KEY_SEPARATOR + APPEND_SELECTED_FACET_CONFIG)?.toUpperCase() == "TRUE" ? true : false 

        // Look through each extra search and find the associated 
        // configurations keys to generate the more links
        transaction?.extraSearches?.each() { extraSearchName, extraSearchTransaction ->            
            String facetNameKey = CONFIG_KEY_PREFIX + CONFIG_KEY_SEPARATOR +  extraSearchName + CONFIG_KEY_SEPARATOR + FACET_NAME_CONFIG
            String categoryLabelKey = CONFIG_KEY_PREFIX + CONFIG_KEY_SEPARATOR +  extraSearchName + CONFIG_KEY_SEPARATOR + CATEGORY_LABEL_CONFIG

            // Get the facet name and facet label using the configuration            
            String facetName = profileConfig.get(facetNameKey)
            String categoryLabel = profileConfig.get(categoryLabelKey)
            
            if(facetName?.trim() && categoryLabel?.trim()) {
                // Add the more link to the extra search
                if( transaction?.response && transaction?.response?.facets) {
                    String moreLink = ""
					
					// Decide if we want to append the selected facets onto the navigation link
					// This is useful if we want to preseve the facet selection when navigation
					// between tabs which by default, it is not preserved
					if(appendSelectedFacets) {		
						moreLink = getMoreLinkWithSelectedFacets(facetName, categoryLabel, transaction.response.facets)
					} 
					else {
						moreLink = getMoreLink(facetName, categoryLabel, transaction.response.facets)						
					}

					if(moreLink?.trim()) {                        
						extraSearchTransaction.response.customData.put(CUSTOM_DATA_NAMESPACE, moreLink)
						log.debug("Added ${CUSTOM_DATA_NAMESPACE}:${moreLink} to the '${extraSearchName}' extra search");
					}
                }   
            }   
            else {
                // Warn the user if the configuration is invalid or incomplete
                log.warn("The following configuration is invalid or incomplete")
                log.warn("${facetNameKey}=${facetName}")
                log.warn("${categoryLabelKey}=${categoryLabel}")

                log.warn("Expected format")
                log.warn("${CONFIG_KEY_PREFIX}.<extra search name>.${FACET_NAME_CONFIG}=<facet name>")
                log.warn("${CONFIG_KEY_PREFIX}.<extra search name>.${CATEGORY_LABEL_CONFIG}=<category label>")                
                
                log.warn("e.g")
                log.warn("stencils.search_preview.programs.facet_name=Display")
                log.warn("stencils.search_preview.programs.category_label=Programs")
                log.warn("stencils.search_preview.courses.facet_name=Display")
                log.warn("stencils.search_preview.courses.category_label=Courses")
            }         
        }
	}

	/**
	 * Determines if tab preview should be enabled for this transaction.
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isSearchPreviewEnabled(def transaction) {
		return isMainSearch(transaction) &&
				isConfigured(transaction)
	}

	/** 
	 * Returns true if the current transaction is the main search. 
	 * i.e. not content auditor, accessibility auditor orfaceted navigation
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isMainSearch(def transaction) {
		return SearchQuestionType.SEARCH.equals(transaction.question.questionType)
	}

	/** 
	 * Returns true if the user has provided enough configurations to enable
	 * tab previews. 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isConfigured(def transaction) {		
		return transaction?.question?.getCurrentProfileConfig().getRawKeys()
			.find() { it.startsWith(CONFIG_KEY_PREFIX) } ? true : false		
	}	

	/** 
	 *	Generate the more link 
	 *
	 * @param facetName - The name of the facet in which contains the facet category 
     *  that the user will be redirected to.
	 * @param categoryLabel - The label of the category config which the user will be 
     *  redirected to.   
	 * @param facet - The list of facets in the response of the search transactions.
	 *
	 **/
	public String getMoreLink(String facetName, String categoryLabel, def facets) {
		def targetFacetCategory = facets
        // Get the facet which is specified
        .find() {
			it.name.toUpperCase() == facetName.toUpperCase() && it?.allValues?.size() > 0
		}
        // Convert from a collection of facet to a collection of facet categories
        .collect() {            
            it.allValues
        }
        .flatten()
        // Get individual facet category which is the target of the more link
        .find() {
            it.label.toUpperCase() == categoryLabel.toUpperCase()
        }

        return targetFacetCategory?.toggleUrl?.trim() ?: "" 
	}

	/** 
	 * Generate the more link and appending all selected facets which are tabs. 
	 * Useful if you want to remember facet selections when transitioning
	 * between tabs.
	 *
	 * @param facetName - The name of the facet in which contains the facet category 
     *  that the user will be redirected to.
	 * @param categoryLabel - The label of the category config which the user will be 
     *  redirected to.   
	 * @param facet - The list of facets in the response of the search transactions.
	 *
	 **/
	public String getMoreLinkWithSelectedFacets(String facetName, String categoryLabel, def facets) {
		return [ getMoreLink(facetName, categoryLabel, facets), getSelectedFacets(facets) ].join("&")
	}

	/** 
	 * Generate the parameters of all selected facets which are not
	 * of the type tabs.
	 *
	 * @param facet - The list of facets in the response of the search transactions.
	 *
	 **/
	public String getSelectedFacets(def facets) {
		String selectedFacets = facets
        // Get the facet which is specified
        .findAll() {
			it?.guessedDisplayType != com.funnelback.publicui.search.model.transaction.facet.FacetDisplayType.TAB && it?.selectedValues?.size() > 0
		}
        // Convert from a collection of facet to a collection of selected categories
        .collect() {            
            it.selectedValues
        }
        // Get individual selected categories rather than an array of selected categories
        .flatten()
		// Convert from a collection of selected categories to collection of strings which can be
		// used as url parameters
        .collect() {
            URLEncoder.encode(it.queryStringParamName, "UTF-8") + "=" + URLEncoder.encode(it.queryStringParamValue, "UTF-8")
        }
		.join("&")

        return selectedFacets ?: "" 
	}
}


/**
 	<p>Hook functions for grouping results by a criteria.</p>

	Available configurations:
	
	stencils.sorting.result_grouping.mode=<COLLECTION|METADATA>

	There are two modes which can be used to group results:
	COLLECTION - Results will be grouped by the collection they are from
	METADATA - Results will be grouped by a metadata class 
	
	stencils.sorting.result_grouping.metadata_class=<metadata class>
	
	Required if METADATA mode has been selected. Determines which 
	metadata class is used to group results.
	
	stencils.sorting.result_grouping.tabs=<command seperated list of tabs>
	
	Allows the ability to restrict the grouping of results to a set of tabs. 
	If no value is set, then grouping will run on all tabs.

	stencils.sorting.result_grouping.target_facet_label.<collection or metadata class>=<new value>
	
	Config prefix which allows the user to rename result categories so that 
	they match facet categories. This is required to generate the "see more" 
	links. This is normally mandatory for collection based groupings.	

	e.g 
	Given  
		- Collection based tabs have been setup. 
				* Web -> membership-association-events-web 
				* Journals -> membership-association-journals-web
		- A tab has been setup which returns all results called "All Results"
	
	The following configuration will:
		- Group results by collections only on the "All Results" tab
		- Generate links which allows the user to navigate to the corresponding tab

	stencils.sorting.result_grouping.mode=COLLECTION
	stencils.sorting.result_grouping.tabs=All Results
	stencils.sorting.result_grouping.target_facet=Tabs
	stencils.sorting.result_grouping.target_facet_label.membership-association-events-web=Events
	stencils.sorting.result_grouping.target_facet_label.membership-association-jobs-web=Jobs
	stencils.sorting.result_grouping.target_facet_label.membership-association-journals-web=Journals
	stencils.sorting.result_grouping.target_facet_label.membership-association-services-web=Services
	stencils.sorting.result_grouping.target_facet_label.membership-association-web=Website
 **/
@Log4j2
class GroupingResultsHookLifecycle {

	static final String CUSTOM_DATA_NAMESPACE = "stencilsGroupingResults"

	/** Value of "Current Rank" which represents the first page of the search results */
	static final int FIRST_PAGE = 1

	/** Name of the facet containing the tabs */
	static final String TABS_FACET_NAME = "Tabs"

	/** 
		String which prefixes all the keys which are applicable to 
		this feature
	*/
	static final String CONFIG_KEY_PREFIX = "stencils.sorting.result_grouping"

	/* Key to derive the white of tabs where grouping should run */
	static final String APPLICABLE_TABS_CONFIG = CONFIG_KEY_PREFIX + ".tabs"
	
	/* The delimiter which is to be used to sepearate tab categories */
	static final String APPLICABLE_TABS_CONFIG_SEPARATOR = ","

	/* 
		Determines what field should be used to group results; 
		either collection or metadata.
	*/
	static final String GROUPING_MODE_CONFIG = CONFIG_KEY_PREFIX + ".mode"

	/* 
		The metadata class which is to be extract from each result if
		METADATA mode is enabled.
	*/
	static final String METADATA_CLASS_FOR_GROUPING_CONFIG = CONFIG_KEY_PREFIX + ".metadata_class"
	
	/* The different modes available for grouping results */
	static final String COLLECTION_GROUPING_MODE = "COLLECTION"
	static final String METADATA_GROUPING_MODE = "METADATA"

	/* Specifies the facet which should be used to generate the more links */
	static final String TARGET_FACET_CONFIG = CONFIG_KEY_PREFIX + ".target_facet"

	/* 
		Config prefix which allows the user to rename result categories so that 
		they match facet categories. Required to generate the "see more" links.
		This is normally only required for collection based groupings.
	*/
	static final String TARGET_FACET_LABEL_CONFIG_KEY_PREFIX = CONFIG_KEY_PREFIX + ".target_facet_label"


	/** Separator for facet prefix and facet name */
	static final String FACET_PREFIX_SEPARATOR = "."

	/** Separator for facet suffix and facet name */
	static final String FACET_SUFFIX_SEPARATOR = "|"

	/** Separator for config keys */
	static final String CONFIG_KEY_SEPARATOR = "."

	/**
	 * Groups results based on the configuration. It will also create
	 * more links which will navigate the user to the associated facet.
	 *  
	 * @param transaction The funnelback transaction which represents the search
	 */
		void postProcess(SearchTransaction transaction) {
		if(isGroupingEnabled(transaction)) {
			groupResults(transaction)
		}
	}

	/**
	 * Determine if grouping should be enabled for this transaction
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isGroupingEnabled(def transaction) {		
		return isConfigured(transaction) &&
					 isMainSearch(transaction) && 
					 isFirstPage(transaction) && 
					 isApplicableToCurrentTab(transaction)
	}

	/** 
	 * Returns true if the user has provided enough configurations to enable
	 * grouping results. 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isConfigured(def transaction) {
		return transaction?.question?.getCurrentProfileConfig().get(GROUPING_MODE_CONFIG) ? true : false		
	}	

	/** 
	 * Returns true if the current transaction is the main search. 
	 * i.e. not content auditor, accessibility auditor orfaceted navigation
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isMainSearch(def transaction) {
		return SearchQuestionType.SEARCH.equals(transaction.question.questionType)
	}

	/**
	 * Returns true only if the transaction relates to a search which is 
	 * on the first page. i.e. The user has not paginated.
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isFirstPage(def transaction) {
		return transaction?.response?.resultPacket?.resultsSummary?.currStart == FIRST_PAGE ? true : false
	}

	/**
	 * Returns true only if the transaction relates to a tab which has grouping turned on 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isApplicableToCurrentTab(def transaction) {
		def profileConfig = transaction.question.getCurrentProfileConfig()

		// Check to see if the user only wants to enable on certain tabs
		if(profileConfig.get(APPLICABLE_TABS_CONFIG)) {
			String [] applicableTabs = profileConfig.get(APPLICABLE_TABS_CONFIG).split(APPLICABLE_TABS_CONFIG_SEPARATOR)
			
			return transaction.question.selectedCategoryValues
				// Filter down to only the tab facet
				.find() {
					def selectedFacet =  it.key.substring(it.key.indexOf(FACET_PREFIX_SEPARATOR) + 1, it.key.lastIndexOf(FACET_SUFFIX_SEPARATOR))			
					selectedFacet == TABS_FACET_NAME
				}
				// See if the selected facet is in the whitelist of applicable value
				.any() {
					selectedCategoryValue ->
					// As it is possible to submit multiple facet categories per facet, we have
					// to look at all selected values to find if any match our whitelist. 
					selectedCategoryValue.value
					.any() {
						selectedFacetLabel ->
						applicableTabs.any { 
							it.toUpperCase() == selectedFacetLabel.toUpperCase() }
					}
				}			
		}
		// If no tab restrictions are in place, we will assume that user wants to
		// enable result grouping on all tabs
		else {
			return true
		}
	}

	/**
	 * Sorts the results by category to implement business rules with the search template. Business rules are:
	 * - Get first result, show all other results in current result set under this category.
	 * - Get next result from a different category, show all other results in current result set under this category. (Repeat)
	 * 
	 * This function caters for two modes. Extracting the grouping criteria on metadata or using the document's collection
   *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public void groupResults(def transaction) {    
		def profileConfig = transaction.question.getCurrentProfileConfig()

		// Determine the mode
		if(profileConfig.get(GROUPING_MODE_CONFIG)) {
			switch(profileConfig.get(GROUPING_MODE_CONFIG).toUpperCase()) {
				// Extract the grouping criteria based on metadata
				case METADATA_GROUPING_MODE:
					groupResults(this.&getMetadata, transaction)
					addGroupingDataToDataModel(this.&getMetadata, transaction)
					break
				// Extract the grouping criteria based the collection
				case COLLECTION_GROUPING_MODE: 
					groupResults(this.&getCollection, transaction)
					addGroupingDataToDataModel(this.&getCollection, transaction)
					break
				// Do nothing if no mode has been configured
				default:
					def message = "'${profileConfig.get(GROUPING_MODE_CONFIG)}' is and invalid value for '${GROUPING_MODE_CONFIG}'. Valid values are '${METADATA_GROUPING_MODE}' or '${COLLECTION_GROUPING_MODE}'"
					log.warn(message)
					break
			}
		} 
	}

	/**
	 * A generic version of groupResults which accepts a closure which determines
	 * how to extract the grouping criteria
   *
	 * @param extractGroupingValue A function which accepts the result and transactions
	 *	and returns the grouping criteria as a String
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public void groupResults(Closure extractGroupingValue, def transaction ) {
		// General the map used to determine the order of the grouping
		def sortMap = transaction?.response?.resultPacket?.results?.inject([:]) {
				sortMap, result ->
				String value = extractGroupingValue(result, transaction)
				if (sortMap.containsKey(value) == false) {
					sortMap.put(value, sortMap.size())
				}

				sortMap					
			}

		// Sort the results if there is at least 1 result					
		if(transaction?.response?.resultPacket?.results?.size() > 0) {
			transaction.response.resultPacket.results
			.sort {
				a, b -> 
				sortMap[extractGroupingValue(a, transaction)] <=> sortMap[extractGroupingValue(b, transaction)]
			}
		}
	}

	/**
	 * Extracts the configured metadata from a result
   *
	 * @param result The result which the grouping criteria is to extracted
	 * @param transaction The funnelback transaction which represents the search.
	 **/
	public String getMetadata(def result, def transaction) {
		def profileConfig = transaction.question.getCurrentProfileConfig()
		def metadataClass = profileConfig.get(METADATA_CLASS_FOR_GROUPING_CONFIG)

		return result.metaData[metadataClass] ?: ""
	}

	/**
	 * Extracts the collection from a result
   *
	 * @param result The result which the grouping criteria is to extracted
	 * @param transaction The funnelback transaction which represents the search.
	 **/
	public String getCollection(def result, def transaction) {
		return result.collection
	}
	
	/** 
	 * Generates the data used to group results and adds it to the data model
	 *
	 * @param extractGroupingValue - A function which will be executed against each 
	 * 	result which returns the category to group by
	 * @param transaction The funnelback transaction which represents the search.
	 *
	 **/
	public void addGroupingDataToDataModel(Closure extractGroupingValue, def transaction) {
		if(transaction?.response?.resultPacket?.results != null
			&& transaction?.response?.customData != null) {
			def results = transaction.response.resultPacket.results		
			def groupingData = getGroupingData(results, extractGroupingValue, transaction)
			transaction?.response?.customData.put(CUSTOM_DATA_NAMESPACE, groupingData)
		}
	}

	/** 
	 * Generates a map which can be used to group results in the frontend 
	 *
	 * @param results - A list of search results
	 * @param extractGroupingValue - A function which will be executed against each 
	 * 	result which returns the category to group by
	 * @param transaction The funnelback transaction which represents the search.
	 *
	 **/
	public getGroupingData(def results, Closure extractGroupingValue, def transaction) {
		def profileConfig = transaction.question.getCurrentProfileConfig()
		
		// Define the container which will store all the data related to grouping results
		def groupingData = [:]

		// Create the top level details of the grouping data
		// Get the current mode from the config. Default to COLLECTION_GROUPING_MODE
		def groupingMode =  profileConfig.get(GROUPING_MODE_CONFIG) ?: COLLECTION_GROUPING_MODE
		groupingData.put("mode", groupingMode)
		
		// Get a unique list of groups (a.k.a category)
		def categories = results
			.collect() {
				extractGroupingValue(it, transaction)
			}
			.unique()

		// Get the title as configured by the user and generate the see more link for each group  
		def groups = categories
			.collect() {
				category ->
				def field = category
				// Get a human readiable form of the field (used as the criteria for grouping) 
				// if the configurations exists. This is normally require when grouping is done 
				// by collections.
				def targetFacetLabel = profileConfig.get(TARGET_FACET_LABEL_CONFIG_KEY_PREFIX + CONFIG_KEY_SEPARATOR + category) ?: category				
				
				def targetFacet = profileConfig.get(TARGET_FACET_CONFIG) ?: category								
				def facets = transaction?.response?.facets

				// Grab the toggle url from the corresponding facet
				def url = facets ? getMoreLink(targetFacet, targetFacetLabel, facets) : ""

				[field: field, label : targetFacetLabel, url: url]
			}

		groupingData.put("groups", groups)

		return groupingData
	}

	/** 
	 *	Generate the more link 
	 *
	 * @param targetFacet - The name of the facet/tab in which the user will be redirected to
	 * @param targetFacetCategory - The label of the facet category in which the user will be redirected to
	 * @param facet - A list of facets
	 *
	 **/
	public String getMoreLink(String targetFacet, String targetFacetCategory, def facets) {
		// Get the instance of the target facet 
		def facet = facets.find {			
			it.name.toUpperCase() == targetFacet.toUpperCase()
		}

		// Get individual facet category which is the target of the more link
		def facetCategory = facet.categories
			.findAll {
				it.values.find { 					
					it.label.toUpperCase() == targetFacetCategory.toUpperCase() 
				}
			}
			.collect {
				it.values
			}
			.flatten()
			.find()

		return  facetCategory ? facetCategory.toggleUrl : ""
	}
}

/**
 * <p>Hook functions to provide a browse experience for a search implementation</p>
 * There are scenarios where users prefer to browse content such as in a directory
 * of services or a program finder catalog. This class  adjust the links in the 
 * primary and secondary tab facets so that the browse option is not being carried 
 * over between tabs. It will also ensure that the selected facet is respected when
 * navigating between the secondary category values. 
 * 
 * e.g. By default, the following is the default behaviour of the product. 
 * Given: 
 * 	- A search implementation with a parimary tab which has three categories; All results, courses, web
 * 	- A user is on the course tab and want to browse all available courses
 * 	- Another tab style facets populated with A to Z (i.e. A, B, C, D) facet categories which allows
 * 		the user to refine by letter.
 * When
 * 	- A user changes the refinement from between A to B
 * Then
 * 	- The selected facet is lost
 */
@Log4j2
class BrowseModeHookLifecycle implements HookLifecycle {

	/** Key holding the config */
	static final String CONFIG_KEY_PREFIX = "stencils.tabs.browse_mode"

	/** Name of the facet containing the primary tabs */
    static final String TABS_FACET_NAME = "Tabs"

	/** The config of the placeholder query used to show all results */
	static final String ALL_RESULTS_QUERY_CONFIG = CONFIG_KEY_PREFIX + ".default_query"
	
	/** The default query which will used to return all documents **/
	static final String DEFAULT_ALL_RESULTS_QUERY = "!PADRENULLQUERY"

	/** 
		The config to determine which parameters are to be removed 
		when navigating between tabs when browse mode is enabled.
	*/
	static final String REMOVE_PARAMETERS_CONFIG = CONFIG_KEY_PREFIX + ".remove_parameters"

	/** Delimeter used to seperate values for the remove parameters config*/
	static final String REMOVE_PARAMETERS_DELIMETER = ","
	
	/** The config to determine which facets are used in browse mode */
	static final String FACETS_TO_DISPLAY_CONFIG = CONFIG_KEY_PREFIX + ".facets"

	/**
	 * 
	 *  
	 * @param transaction
	 */
	void postProcess(SearchTransaction transaction) {
		if (isBrowseModeEnabled(transaction)) {
			removeParametersFromTabNavigation(transaction)
			addSelectedTabFacetToSecondaryTabs(transaction)
		}
	}

	/**
	 * 
	 * Removes the browse mode parameter when navigating between the primary tabs
	 *  
	 * @param transaction
	 */
	public void removeParametersFromTabNavigation(def transaction) {

		String [] removeParameters = transaction?.question
										?.getCurrentProfileConfig()
										?.get(REMOVE_PARAMETERS_CONFIG)
										?.split(REMOVE_PARAMETERS_DELIMETER)
										// Required to remove nulls and empty strings
										?.findAll() ?: []
		removeParameters.each() {
			parameter ->

			transaction?.response?.facets
				.find() {
					// Grab the primary tab
					facet -> facet.name == TABS_FACET_NAME
				}
				.each() {
					tabfacet ->

					tabfacet.allValues
						.findAll() {
							// To be defensive, we only want to run the code when 
							// the browse mode parameter is present in the url.							
							facetCategory -> 
							facetCategory?.toggleUrl =~ /(?i)${parameter}=/
						}
						.each() {
							// Remove the browse mode select from all tab facet categories.
							facetCategory ->
							facetCategory.toggleUrl = facetCategory.toggleUrl.replaceAll(/(?i)${parameter}=[^&]+&/, "")
							facetCategory.toggleUrl = facetCategory.toggleUrl.replaceAll(/(?i)&${parameter}=[^&]+/, "")
						}
				}
		}
	}

	public void addSelectedTabFacetToSecondaryTabs(def transaction) {

		// Get the query parameters for the current selected tab
		// Assuming that tabs can only have 1 selected value at any one time
		String selectedTabQueryParameter = transaction?.response?.facets
			.find() {
				facet -> facet.name == TABS_FACET_NAME
			}
			.collect(){
				facet -> facet.selectedValues				
			}
			// Flatten an list of array of selected value to just an list of selected value
			.flatten()
			.collect() {
				selectedValue -> selectedValue.queryStringParam
			}
			// Convert an array of strings to an array of strings.
			//.flatten()			
			.find()

		// Get all tab facets which are is not the main 
		if(selectedTabQueryParameter != null) {
			transaction?.response?.facets
				.findAll() {
					facet -> facet.guessedDisplayType.equals(FacetDisplayType.TAB) && facet.name != TABS_FACET_NAME
				}
				.each() {
					facet -> 
					
					facet.allValues
						.findAll() {
							// To be defensive, we only want to add the parameter if it does not already exist.
							// This may happen in the future if the product changes its behaviour.
							facetCategory -> facetCategory.toggleUrl.contains(selectedTabQueryParameter) == false
						}
						.each() {
							// Modify the toggle url for each category value so that it retains the current 
							// selected tab
							facetCategory -> facetCategory.toggleUrl += "&" + selectedTabQueryParameter
						}
				}
		} 
	}

	/**
	 * Determines if tab preview should be enabled for this transaction.
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isBrowseModeEnabled(def transaction) {
		return isMainSearch(transaction) &&
				isConfigured(transaction)
	}

	/** 
	 * Returns true if the current transaction is the main search. 
	 * i.e. not content auditor, accessibility auditor orfaceted navigation
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isMainSearch(def transaction) {
		return SearchQuestionType.SEARCH.equals(transaction.question.questionType)
	}

	/** 
	 * Returns true if the user has provided enough configurations to enable
	 * browse mode on the current selected tab. 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isConfigured(def transaction) {		

		// Get the query parameters for the current selected tab
		// Assuming that tabs can only have 1 selected value at any one time
		String selectedTab = transaction?.response?.facets
			.find() {
				facet -> facet.name == TABS_FACET_NAME
			}
			.collect(){
				facet -> facet.selectedValues				
			}
			// Flatten an list of array of selected value to just an list of selected value
			.flatten()
			.collect() {
				selectedValue -> selectedValue.label
			}		
			.find()		
				
		return transaction?.question?.getCurrentProfileConfig().getRawKeys()
			.find() { it.equalsIgnoreCase("${FACETS_TO_DISPLAY_CONFIG}.${selectedTab}") } ? true : false		
	}	
}

/**
 * 	<p>Hook functions to prevent placeholder queries from being displayed to 
 * 	the end user</p>
	
	Available configurations:
	
	stencils.query.clean=<queries>

	<queries> - A comma (,) separated list of queries which will be
	hidden from the user. The logic works on a whole phrase matching basis.

	i.e.

	stencils.query.clean=!padrenullquery

	Queries which example match "!padrenullquery" will be hidden from the user.
	However queries such as "!padrnenullquery and something" will not be affected

	A few more examples can be found below:
	
	stencils.query.clean=!padrenull,!showall,!asdasd

	The query for "!padrenullquery", "!showall", "!asdasd" will be hidden.

	stencils.query.clean=!padrenull courseName:science

	The query for "!padrenull courseName:science" will be hidden but the query for 
	"!padrenull" will still be visible.
 * 
 */
@Log4j2
class QueryHookLifecycle implements HookLifecycle {

	/** Key holding the config */
	static final String CONFIG_KEY_PREFIX = "stencils.query"

	/** Config which holds a list of queries to hide from the end user */
	static final String CLEAN_QUERY_CONFIG = CONFIG_KEY_PREFIX + ".clean"

	/** Delimeter used to seperate values for the clear query config */
	static final String CLEAN_QUERY_DELIMETER = ","

	/**
	 *
	 * @param transaction
	 */
	void postProcess(SearchTransaction transaction) {
		if (isQueryEnabled(transaction)) {
			cleanQuery(transaction)
		}
	}

	/**
	 * Removes the placeholder query from the search transaction so that
	 * it is not exposed to the end user. 
	 *  
	 * @param transaction
	 */
	void cleanQuery(SearchTransaction transaction) {
		
		String [] queriesToClean = transaction?.question?.getCurrentProfileConfig()?.get(CLEAN_QUERY_CONFIG)
									?.split(CLEAN_QUERY_DELIMETER)
									.findAll() ?: []

		// Remove the user's query if it matches any of the values which is to be cleaned
		if (transaction?.question?.query && queriesToClean.any{ it.equalsIgnoreCase(transaction.question.query) }){
			transaction.question.query = ""	
			transaction?.response?.resultPacket?.queryCleaned = ""
		}
	}


	/**
	 * Determines if tab preview should be enabled for this transaction.
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isQueryEnabled(def transaction) {
		return isMainSearch(transaction) &&
				isConfigured(transaction)
	}

	/** 
	 * Returns true if the current transaction is the main search. 
	 * i.e. not content auditor, accessibility auditor orfaceted navigation
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isMainSearch(def transaction) {
		return SearchQuestionType.SEARCH.equals(transaction.question.questionType)
	}

	/** 
	 * Returns true if the user has provided enough configurations to enable
	 * the query functions 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isConfigured(def transaction) {				
		return transaction?.question?.getCurrentProfileConfig().get(CLEAN_QUERY_CONFIG) ? true : false		
	}	
}