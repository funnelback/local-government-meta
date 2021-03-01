<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    A collections of common elements used in search implementations.

    If a particular feature requires multiple presentations or is made
    up more than one macro, consider refactoring the feature to 
    its own freemarker template.
-->

<#--
    Generates a search form for the current collection, passing through the
    relevant parameters like collection, profile, form, scope, ...

    @param preserveTab Boolean indicating if searching via the form should preserve the currently selected tab or not
    @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm preserveTab=true class="">
    <!-- base.SearchForm -->
    <form 
        action="${question.getCurrentProfileConfig().get("ui.modern.search_link")}" 
        method="GET"
        role="search"
        <#if class?has_content>class="${class}"</#if>
        >
        <input type="hidden" name="collection" value="${question.collection.id}">

        <#-- Output all the parameters which are to persist between queries -->
        <#list ["enc", "form", "scope", "lang", "profile", "userType", "displayMode", "num_ranks"] as parameter>
            <@s.IfDefCGI name=parameter>
                <input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}">
            </@s.IfDefCGI>
        </#list>

        <#if preserveTab>
            <#list question.selectedCategoryValues?keys as facetKey>
                <#if facetKey?starts_with("f.Tabs|")>
                    <#list question.selectedCategoryValues[facetKey] as value>
                        <input type="hidden" name="${facetKey}" value="${value}">
                    </#list>
                </#if>
            </#list>
        </#if>

        <#nested>
    </form>
</#macro>

<#--
  Display query blending notice
-->
<#macro Blending>
    <!-- base.Blending -->
    <#if (response.resultPacket.QSups)!?size &gt; 0>        
        <blockquote class="search-blending">
        <span class="fas fa-info-circle"></span>
        Your query has been expanded to <strong><#list response.resultPacket.QSups as qsup> ${qsup.query}<#if qsup_has_next>, </#if></#list></strong>.
        &nbsp;Search for <a class="highlight" href="?${QueryString}&amp;qsup=off" title="Turn off query expansion"><em>${question.originalQuery}</em></a> instead.
        </blockquote>
    </#if>
</#macro>

<#--
  Display spelling suggestion notice
-->
<#macro Spelling>
    <!-- base.Spelling -->
    <#if (response.resultPacket.spell)??>
        <blockquote class="search-spelling">
            Did you mean <em><a class="highlight" href="${question.collection.configuration.value("ui.modern.search_link")}?${response.resultPacket.spell.url}" title="Spelling suggestion">${(response.resultPacket.spell.text)!}</a></em>?
        </blockquote>
    </#if>
</#macro>

<#--
    Display result counts
-->
<#macro Counts>
    <!-- base.Counts -->
    <span class="search-results__total">                                                                    
        <#if ((response.resultPacket.resultsSummary.totalMatching)!0) == 0>
            <span class="search-counts-total-matching">0</span> search results for <strong class="highlight"><@s.QueryClean /></strong>
        </#if>
        <#if ((response.resultPacket.resultsSummary.totalMatching)!0) != 0>
            <span class="search-counts-page-start">${(response.resultPacket.resultsSummary.currStart)!}</span> -
            <span class="search-counts-page-end">${(response.resultPacket.resultsSummary.currEnd)!}</span> of
            <span class="search-counts-total-matching">${(response.resultPacket.resultsSummary.totalMatching)!?string.number}</span>
            <#if (question.inputParameterMap["s"])!?has_content && question.inputParameterMap["s"]?contains("?:")>
                <em>collapsed</em> 
            </#if>
            search results  
            
            <#-- Display the query if it is not the placeholder -->
            <#if (question.query)!?has_content && 
                (question.query)!?upper_case != (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.default_query"))!"">
                for <strong class="highlight"><@s.QueryClean></@s.QueryClean></strong>
            <#else>
                <#-- We normally don't want to display the placeholder value -->
            </#if>
            
            <#-- Display any blended queries -->
            <#list response.resultPacket.QSups as qsup>
                or <strong class="highlight">${(qsup.query)!}</strong>
                <#if qsup_has_next>, </#if>
            </#list>
        </#if>

        <#-- 
            Display count for the number of document which match some but
            not all of the the query terms.
        -->
        <#if ((response.resultPacket.resultsSummary.partiallyMatching)!0) != 0>
            where <span class="search-counts-fully-matching">${(response.resultPacket.resultsSummary.fullyMatching)!?string.number}</span>
            match all words and <span class="search-counts-partially-matching">${(response.resultPacket.resultsSummary.partiallyMatching)!?string.number}</span>
            match some words.
        </#if>
        
        <#-- 
            Display the count for the number of documents which have been collapsed.
            The collapsed results functionality prevents similar documents from being 
            over represented on the search results page.
        --> 
        <#if ((response.resultPacket.resultsSummary.collapsed)!0) != 0>
            where 
            <span class="search-counts-collapsed">${(response.resultPacket.resultsSummary.collapsed)!}</span>
            very similar results have been hidden.
        </#if>
    </span>
</#macro>

<#--
  Message to display when there are no results
-->
<#macro NoResults>
    <!-- base.NoResults -->
    <#if (response.resultPacket.resultsSummary.totalMatching)!?has_content &&
        response.resultPacket.resultsSummary.totalMatching == 0>
        <!-- base.NoResults -->
        <section class="module-info content-wrapper">
            <figure class="module-info__bg">
                <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/no-results-icon.svg" alt="">
            </figure>
            <h2 class="module-info__title">No matching results</h2>
            <p class="module-info__desc">
                Your search for <strong><@s.QueryClean /></strong> did not return any results.
            </p>
        </section>
    </#if>
</#macro>

<#-- Obtain the result mode from the CGI paramters; Valid values are LIST and CARD -->
<#function getDisplayMode question>
    <#-- Default the display mode to "list" -->
    <#assign displayMode = ""> 

    <#-- Get the mode that is currently configured -->
    <#if (question.inputParameterMap["displayMode"])!?has_content>
        <#-- Get the value from the user's selection -->
        <#assign displayMode = question.inputParameterMap["displayMode"]!?upper_case>
    <#elseif (question.getCurrentProfileConfig().get("stencils.results.display_mode"))!?has_content>
        <#-- Get the value from profile config -->
        <#assign displayMode = question.getCurrentProfileConfig().get("stencils.results.display_mode")!?upper_case>
    <#else>
        <#-- Default -->
        <#assign displayMode = "LIST"> 
    </#if>

    <#return displayMode>
</#function>

<#--
    Runs the best code when the specified display mode is selected.
-->
<#macro IsDisplayMode mode="LIST">
    <#if getDisplayMode(question) == mode!?upper_case>
        <#nested> 
    </#if>
</#macro>

<#--
    Show the various display mode options to the user
-->
<#macro DisplayMode>
    <!-- base.displayMode -->
    <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=card' 
        class="search-results__icon search-results__icon--box <#if getDisplayMode(question)! == 'CARD'>active</#if>"
        title="Display results as cards">
        <span class="sr-only">Card view</span>
    </a>
    <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=list' 
        class="search-results__icon search-results__icon--list <#if getDisplayMode(question)! == 'LIST'>active</#if>"
        title="Display results as a list">
        <span class="sr-only">List view</span>
    </a>
</#macro>

<#-- 
    Generate the HTML for advanced features which control the search results such as 
    sorting and number of results to display
-->
<#macro SearchTools>
    <div class="search-results__tools clearfix">
        <@base.Counts /> 
        <div class="search-results__tools-right">
            <@facets.ClearAllFacets />            
            <@base.LimitDropdown />
            <@base.SortDropdown />
            <@base.DisplayMode />                    
        </div>
    </div>
</#macro>

<#--
  Generate an HTML drop-down for sorting results

  @param options Map of sort options, where keys are the `sort` paratmeter (e.g. `date`) and values the label (e.g. `Date (Newest first)`)
-->
<#macro SortDropdown id="fb-sort-dropdown" options={
  "": "Relevance",
  "date": "Date (Newest first)",
  "adate": "Date (Oldest first)",
  "title": "Title (A-Z)",
  "dtitle": "Title (Z-A)",
  "prox": "Distance",
  "url": "URL (A-Z)",
  "durl": "URL (Z-A)",
  "shuffle": "Shuffle"} >
    <!-- base.SortDropdown -->
    <section class="dropdown-list ${id}">
        <span id=${id} class="sr-only">
            Sort results by
        </span>
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="listbox" aria-expanded="false">
            <span>${(options[question.inputParameterMap["sort"]])!"Sort by"}</span>
        </button>
        <ul class="dropdown-list__list" 
            role="listbox" 
            tabindex="-1"
            aria-labelledby=${id}>
            <#list options as key, value>
                <#if ((options[question.inputParameterMap["sort"]])!"") == value>
                    <li role="option" aria-selected="true">                
                        <a class="dropdown-list__list-link" title="Sort by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "sort")}&sort=${key}">
                                <i class="fas fa-check"></i>
                            ${value}
                        </a>
                    </li>
                <#else>
                    <li role="option" aria-selected="false">                
                        <a class="dropdown-list__list-link" title="Sort by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "sort")}&sort=${key}">
                            ${value}
                        </a>
                    </li>                                
                </#if>
            </#list>
        </ul>
    </section>
</#macro>

<#--
  Generate an HTML drop-down to control the number of results

  @param limits Array of number of results to provide (defaults to 10, 20, 50)
-->
<#macro LimitDropdown id="fb-limit-dropdown" limits=[10, 20, 50]>
    <!-- base.LimitDropdown -->
    <section class="dropdown-list ${id}">
        <span id=${id} class="sr-only">
            Limit the number of results to display
        </span>    
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="listbox" aria-expanded="false">
            <span>${question.inputParameterMap["num_ranks"]!"10"}</span>
        </button>
        <ul class="dropdown-list__list" 
            role="listbox" tabindex="-1"
            aria-labelledby=${id}>
            <#list limits as limit>
                <#if ((question.inputParameterMap["num_ranks"]?number)!0) == limit>
                    <#-- Selected case -->
                    <li role="option" aria-selected="true">
                        <a class="dropdown-list__list-link" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">
                            <i class="fas fa-check"></i>
                            ${limit} results
                        </a>
                    </li>
                <#else>
                    <#-- Unselected case -->
                    <li role="option" aria-selected="false">
                        <a class="dropdown-list__list-link" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">
                            ${limit} results
                        </a>
                    </li>
                </#if>
            </#list>
        </ul>
    </section>
</#macro>

<#--
  Display paging controls
-->
<#macro Paging>
    <!-- base.Paging -->
    <section class="pagination">
        <nav class="pagination__nav" role="navigation" aria-label="Pagination navigation">
            <#-- Previous page -->
            <#if (response.customData.stencilsPaging.previousUrl)??>
                <div class="pagination__item pagination__item-navigation pagination__item-previous">
                    <a class="pagination__link" 
                        rel="prev" 
                        href="${response.customData.stencilsPaging.previousUrl}">
                        <span class="sr-only">
                            Go to the
                        </span>
                        <span class="pagination__label">Prev</span>
                        <span class="sr-only">
                            page
                        </span>
                    </a>
                </div>
            </#if>

            <#-- Sibling pages -->
            <#if (response.customData.stencilsPaging.pages)!?has_content &&
                response.customData.stencilsPaging.pages?size gt 1>
                <ul class="pagination__pages-list">
                    <#list response.customData.stencilsPaging.pages as page>
                        <#if page.selected>
                            <li class="pagination__item pagination__item--active" aria-current="page">
                                <span class="pagination__current">
                                    <span class="pagination__label">${page.number}</span>
                                </span>                            
                            </li>
                        <#else>                    
                            <li class="pagination__item">
                                <a class="pagination__link" href="${page.url}">
                                    <span class="sr-only">
                                        Go to page
                                    </span>
                                    <span class="pagination__label">${page.number}</span>
                                </a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>

            <#-- Next page -->
            <#if (response.customData.stencilsPaging.nextUrl)??>            
                <div class="pagination__item pagination__item-navigation pagination__item-next">
                    <a class="pagination__link" 
                        rel="next" 
                        href="${response.customData.stencilsPaging.nextUrl}">
                        <span class="sr-only">
                            Go to the
                        </span>
                        <span class="pagination__label">Next</span>
                        <span class="sr-only">
                            page
                        </span>
                    </a>
                </div>
            </#if> 
        </nav>
    </section>
</#macro>

<#-- 
    Determines if the results are to be displayed normally
    or grouped together by some criteria

    ToDo - Add browsing results to this
-->
<#macro ResultList nestedRank=-1>
    <#assign displayMode = getDisplayMode(question)>

    <#if (response.customData["stencilsGroupingResults"].mode)!?has_content>
        <@GroupedResults view=displayMode/>
    <#else>
        <@StandardResults view=displayMode nestedRank=-1>
            <#nested>    
        </@StandardResults>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param nestedRank Before which result to insert the nested content of the macro.
        This is used to insert content (usually an extra search) between results.
-->
<#macro StandardResults view="LIST" nestedRank=-1>
    <!-- base.StandardResults -->
    <article class="search-results__list <#if getDisplayMode(question)! == 'LIST' || getDisplayMode(question)! == 'BROWSE'>search-results__list--list-view</#if>">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <@TierBar result=result />
            <#else>
                <#if nestedRank gte 0 && result.rank == nestedRank>
                    <#nested>
                </#if>
                
                <#-- Display the result based on the configured template -->
                <@Result result=result view=view/>                
            </#if>
        </#list>
    </article>
</#macro>

<#--
  Display a tier bar
-->
<#macro TierBar result>
    <!-- base.TierBar -->
    <#-- A tier bar -->
    <#if result.matched != result.outOf>
        <h2 class="search-tier text-muted">Results that match ${result.matched} of ${result.outOf} words</h2>
    <#else>
        <h2 class="sr-only search-tier">Fully-matching results</h2>
    </#if>
    <#-- Print event tier bars if they exist -->
    <#if result.eventDate??>
        <h2 class="text-muted search-tier">Events on ${result.eventDate?date}</h2>
    </#if>
</#macro>

<#--
    Displays a search result using the the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro Result result question=question view="LIST">
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <#-- Output the result using the presentation specified in the configurations -->
        <@.main[resultDisplayLibrary].Result result=result view=view />
    <#elseif .main["results"]??>
        <#-- Default presentation -->
        <@.main["results"].Result result=result view=view />
    <#elseif .main["project"]??>
        <#-- Default presentation for legacy (pre 15.24.x) implementations -->
        <@.main["project"].Result result=result view=view />
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>

<#macro GroupedResults view="LIST">
    <#-- Loop through each grouped result tier -->
    <#if (response.resultPacket.results)!?has_content>
        <article class="search-results__list <#if getDisplayMode(question)! == 'LIST' || getDisplayMode(question)! == 'BROWSE'>search-results__list--list-view</#if>">
            <#list (response.customData["stencilsGroupingResults"].groups)![] as group>
                <#-- Create facet link to be used in the title and "see more" -->
                <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                <#assign facetLink = (group.url)!"">

                <a class="highlight search-results__group-label" href="${searchLink + facetLink}">           
                    ${group.label}
                </a>
        
                <#list response.resultPacket.results as result>                        
                    <#-- Display the result based on the configured template -->
                    <#switch ((response.customData["stencilsGroupingResults"].mode)!"")?upper_case>
                        <#case "METADATA">
                            <#if (result.listMetadata["group.field"]?first)!?has_content>
                                <@Result result=result view=view />
                            </#if>
                            <#break> 
                        <#case "COLLECTION">
                            <#if result.collection == (group.field)!"">
                                <@Result result=result view=view />
                            </#if>
                            <#break>
                        <#default>                
                            <#break>
                    </#switch>         
                </#list>

                <#-- See more link -->
                <a href="${searchLink + facetLink}" class="search-results__group-see-more-label highlight"> 
                    <i class="fas fa-arrow-right mr-1"></i>
                    See more ${group.label} 
                </a>
            </#list>    
        </article>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;
-->
<#macro QuickViewTemplates>
    <!-- base.QuickViewTemplates -->
    <#list (response.resultPacket.resultsWithTierBars)![] as result>
        <#if result.class.simpleName == "TierBar">
            <#-- Ignore tier bars -->
        <#else>            
            <#-- Display the result based on the configured template -->
            <@QuickViewTemplate result=result />                
        </#if>
    </#list>
</#macro>

<#--
    Displays a search result using the the right quick view template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro QuickViewTemplate result question=question>
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <@.main[resultDisplayLibrary].QuickView result=result />
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace -->
        <@.main["project"].QuickView result=result/>
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>

<#-- 
    Creates a valid CSS ID by replacing all special characters (except for hypens)
    with underscores (_). Note mulitple underscores will be replace by 1 underscore.

    @param input A string which is to be converted to a valid CSS ID.
-->
<#function getCssID input="">
    <#return (input)!?replace('[^A-Za-z0-9-]+', '_', 'r')>
</#function>