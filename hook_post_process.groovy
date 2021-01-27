import groovy.util.logging.Log4j2

import com.funnelback.publicui.search.model.transaction.SearchTransaction
import com.funnelback.publicui.search.model.transaction.SearchQuestion.SearchQuestionType
import com.funnelback.publicui.search.model.transaction.facet.FacetDisplayType
import com.funnelback.stencils.hook.support.HookLifecycle
import java.net.URLEncoder

new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)

new BrowseModeHookLifecycle().postProcess(transaction)
new QueryHookLifecycle().postProcess(transaction)

/**
 * TODO: Please remove or adjust for implementatons.
 * The following functions are used for demo purposes.
 */

// Remove council specific names from the results
transaction?.response?.resultPacket?.results.each() {
	result ->	

	result.title = result.title.replaceAll(/\s+-\s+Camden Council/, "")
	result.title = result.title.replaceAll(/\s*\|\s*SF311/, "")
}

/**
 * This code add the custom sort to the facet so that
 * category letter is sorted in the following format:
 * A, B, C ... X, Y, Z, All results,
 * Instead of 
 * A, All results, B, C ... X, Y, Z
 * 
 * TODO: Update or create a new facet which contains only the 
 * the first letter of the name/title of the item you want
 * browse by. Then modify the code below so that the facet.name
 * matches the name of facet create or updated.
 *
 * This will be made configurable in version 16.  
 */
transaction?.response?.facets
	.findAll() {
		facet ->
		// Search for facets names which requires the custom sort
		// Generally, this should be the facet used to create A-Z listing
		facet.name == "Category letter"
	}
	.each() {
		facet ->
		// The code for the comparator can be found under 
		// $COLLECTION/@groovy/facet/comparator
		facet.setCustomComparator(new facet.comparator.LabelLengthComparator());
	}

/**
 * The following classes are require to enabled features recently created. 
 * They will be shipped with Stencils v16 and higher.
 */  

/**
 * <p>Hook functions to provide a browse experience for a search implementation</p>
 * There are scenarios where users prefer to browse content such as in a directory
 * of services or a program finder catalog. 
 *
 * This class adjusts the links in the primary and secondary tab facets so that 
 * the browse option is not being carried over between tabs. It will also ensure that
 * the selected tab facet is respected when navigating between the secondary category 
 * values. 
 * 
 * e.g. By default, the following is the default behaviour of the product. 
 * Given: 
 * 	- A search implementation with a parimary tab which has three categories; All results, 
 *		courses, web
 * 	- A user is on the course tab and want to browse all available courses
 * 	- Another tab style facets populated with A to Z (i.e. A, B, C, D) facet categories which allows
 * 		the user to refine by letter.
 * When
 * 	- A user changes the refinement from between A to B.
 * Then
 * 	- The user will be sent back to the default tab (All results). 
 *		i.e. The selected tab of "courses" will be lost.  
 * 
 * This class will change it so that the above will be:
 * - The user will remain on the courses tab with B selected.
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

	/**
	 * 
	 * By default, the product strips out parameters related to tabs that 
	 * are selected. This means that when a user navigates from one
	 * secondary tab facet to another, the selected value for the primary 
	 * tab will be lost.
	 *
	 * This function aims to add the selected value of the primary tab facet
	 * back to the secondary tab facet. 
	 * 
	 * @param transaction
	 */
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

		// Get all tab facets which are not the primary tab facet 
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
	 * Determines if browse mode should be enabled for this transaction.
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