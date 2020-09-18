<#ftl encoding="utf-8" output_format="HTML" />

<#-- Not to be used in production -->

<#-- This file should be replaced by a copy of the Stencils file when
    deploying, to allow customization. Explicitly fail if the collection is not
    the showcase collection. To fix it, copy the file from
    $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
    question.collection.id == 'membership-association-meta' ||
    question.collection.id == 'local-government-meta'
    >
    <#include "/share/stencils/libraries/base/base.ftl">
<#else>
    <#-- Create a dummy version of a base.ftl macro, as a way to display
        the error message -->
    <#macro SearchForm>
        <div class="alert alert-danger">
            <p><code>base.ftl</code> is currently directly including the Stencils
            file. This is discouraged as Stencils changes will break the collection
            templates. Please make a copy of <code>base.ftl</code> instead, from the
            Stencils sources (<code>$SEARCH_HOME/share/stencils/libraries/</code>).</p>

            <p>Subsequent template processing will fail until this is fixed.</p>
        </div>
    </#macro>
</#if>

<#-- 
    Macros specific to Vertical Product instance 
    These can override those found in Stencils. 
    i.e. Given /share/stencils/libraries/foo.ftl defines @SomeMacro,
    and is included is this template, it can be overriden by 
    defining <macro SomeMacro>. 
--> 


<#---
    Generates a search form for the current collection, passing through the
    relevant parameters like collection, profile, form, scope, ...

    @param preserveTab Boolean indicating if searching via the form should preserve the currently selected tab or not
    @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm preserveTab=true class="">
    <form action="${question.getCurrentProfileConfig().get("ui.modern.search_link")}" method="GET"<#if class?has_content> class="${class}"</#if>>
        <input type="hidden" name="collection" value="${question.collection.id}">

        <#list ["enc", "form", "scope", "lang", "profile", "userType", "displayMode"] as parameter>
            <@s.IfDefCGI name=parameter><input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}"></@s.IfDefCGI>
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

<#macro DisplayMode>

    <div class="search-results__tools">
        <h2 class="search-results__tools-title sr-only">Search Funnelback University</h2>
        <@base.Counts />
        <div class="search-results__tools-right">
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
        </div>
    </div>
</#macro>

<#--
  Generate an HTML drop-down for sorting results

  @param options Map of sort options, where keys are the `sort` paratmeter (e.g. `date`) and values the label (e.g. `Date (Newest first)`)
-->
<#macro SortDropdown options={
  "": "Relevance",
  "date": "Date (Newest first)",
  "adate": "Date (Oldest first)",
  "title": "Title (A-Z)",
  "dtitle": "Title (Z-A)",
  "prox": "Distance",
  "url": "URL (A-Z)",
  "durl": "URL (Z-A)",
  "shuffle": "Shuffle"} >


    <section class="dropdown-list">
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
            <span>${(options[question.inputParameterMap["sort"]])!"Sort by"}</span>
        </button>
        <ul class="dropdown-list__list" role="listbox" tabindex="-1"">
            <#list options as key, value>
                <li role="option">
                    <a class="dropdown-list__list-link" title="Sort by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "sort")}&sort=${key}">${value}</a>
                </li>
            </#list>
        </ul>
    </section>
</#macro>

<#--
  Generate an HTML drop-down to control the number of results

  @param limits Array of number of results to provide (defaults to 10, 20, 50)
-->
<#macro LimitDropdown limits=[10, 20, 50]>

    <section class="dropdown-list">
        <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
            <span>${question.inputParameterMap["num_ranks"]!"10"}</span>
        </button>
        <ul class="dropdown-list__list" role="listbox" tabindex="-1"">
            <#list limits as limit>
                <li role="option">
                    <a class="dropdown-list__list-link" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">${limit} results</a>
                </li>
            </#list>
        </ul>
    </section>
</#macro>

<#-- 
    Determines if the results are to be displayed normally
    or grouped together by some criteria
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
    <article class="search-results__list <#if getDisplayMode(question)! == 'LIST'>search-results__list--list-view</#if>">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <div class="row tier-bar">      
                    <div class="col-md-12">
                        <@TierBar result=result />
                    </div>
                </div>
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
        <@.main[resultDisplayLibrary].Result result=result view=view />
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace -->
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
        <#list (response.customData["stencilsGroupingResults"].groups)![] as group>
            <div class="mb-3">
                <#-- Create facet link to be used in the title and "see more" -->
                <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                <#assign facetLink = (group.url)!"">

                <span>
                    <h3>
                        <a class="text-muted" href="${searchLink + facetLink}">           
                            ${group.label}
                        </a>
                    </h3>
                </span>
        
                <ol class="list-unstyled fb-result-set fb-display-mode--${view?lower_case}">
                    <#list response.resultPacket.results as result>                        
                        <#-- Display the result based on the configured template -->
                        <#switch ((response.customData["stencilsGroupingResults"].mode)!"")?upper_case>
                            <#case "METADATA">
                                <#if (result.metaData[group.field])!?has_content>
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
                </ol>

                <#-- See more link -->
                <span class="clearfix">        
                    <a href="${searchLink + facetLink}"> 
                        <i class="fas fa-arrow-right mr-1"></i>
                        See more ${group.label} 
                    </a>
                </span>
            </div>
        </#list>    
    </#if>
</#macro>

<#--
  Display query blending notice
-->
<#macro Blending>
  <#if (response.resultPacket.QSups)!?size &gt; 0>
    <blockquote class="blockquote">
      <span class="fas fa-info-circle"></span>
      Your query has been expanded to <strong><#list response.resultPacket.QSups as qsup> ${qsup.query}<#if qsup_has_next>, </#if></#list></strong>.
      &nbsp;Search for <a href="?${QueryString}&amp;qsup=off" title="Turn off query expansion"><em>${question.originalQuery}</em></a> instead.
    </blockquote>
  </#if>
</#macro>

<#--
  Display spelling suggestion notice
-->
<#macro Spelling>
    <#if (response.resultPacket.spell)??>
      <div class="search-spelling">
        <span class="fas fa-question-circle"></span>
        Did you mean <em><a href="${question.collection.configuration.value("ui.modern.search_link")}?${response.resultPacket.spell.url}" title="Spelling suggestion">${(response.resultPacket.spell.text)!}</a></em>?
      </div>
    </#if>
</#macro>

<#--
  Message to display when there are no results
-->
<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)!?has_content &&
        response.resultPacket.resultsSummary.totalMatching == 0>
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

<#--
  Display the contextual navigation panel only if there are valid values
-->
<#macro ContextualNavigation>
    <#if (response.resultPacket.contextualNavigation.categories)!?has_content &&
        response.resultPacket.contextualNavigation.categories?filter(category -> category.clusters?size gt 0)?size gt 0>
        <section class="related-links">
            <h2 class="related-links__title">
                Related searches for <strong><@s.QueryClean /></strong>
            </h2>
            <ul class="related-links__list">
                <#list (response.resultPacket.contextualNavigation.categories)![] as category>
                        <#list category.clusters as cluster>
                            <li class="related-links__item">
                                <a href="${cluster.href}" class="related-links__link">
                                    ${cluster.label?replace("...", " <strong>${response.resultPacket.contextualNavigation.searchTerm} </strong> ")?no_esc}
                                </a>
                            </li>
                        </#list>
                </#list>
            </ul>
        </section>
    </#if>
</#macro>

<#--
    Display result counts
-->
<#macro Counts>
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
            </#if>search results for <strong class="highlight"><@s.QueryClean></@s.QueryClean></strong> 
            <#list response.resultPacket.QSups as qsup>
                or <strong class="highlight">${(qsup.query)!}</strong>
                <#if qsup_has_next>, </#if>
            </#list>
        </#if>

        <#if ((response.resultPacket.resultsSummary.partiallyMatching)!0) != 0>
            where <span class="search-counts-fully-matching">${(response.resultPacket.resultsSummary.fullyMatching)!?string.number}</span>
            match all words and <span class="search-counts-partially-matching">${(response.resultPacket.resultsSummary.partiallyMatching)!?string.number}</span>
            match some words.
        </#if>
        <#if ((response.resultPacket.resultsSummary.collapsed)!0) != 0>
            <span class="search-counts-collapsed">${(response.resultPacket.resultsSummary.collapsed)!}</span>
            very similar results included.
        </#if>
    </span>
</#macro>

<#--
  Display paging controls
-->
<#macro Paging>
    <section class="pagination">
        <nav class="pagination__nav" aria-label="Pagination Navigation">
            <#-- Previous page -->
            <#if (response.customData.stencilsPaging.previousUrl)??>
                <div class="pagination__item pagination__item-navigation pagination__item-previous">
                    <a class="pagination__link" rel="prev" href="${response.customData.stencilsPaging.previousUrl}">
                        <span class="pagination__label">Prev</span>
                    </a>
                </div>
            </#if>

            <#-- Sibling pages -->
            <#if (response.customData.stencilsPaging.pages)!?has_content &&
                response.customData.stencilsPaging.pages?size gt 1>
                <ul class="pagination__pages-list">
                    <#list response.customData.stencilsPaging.pages as page>
                        <#if page.selected>
                            <li class="pagination__item pagination__item--active">

                                <span class="pagination__current" aria-label="Current Page, Page ${page.number}">
                                    <span class="pagination__label">${page.number}</span>
                                </span>                            
                            </li>
                        <#else>                    
                            <li class="pagination__item">
                                <a class="pagination__link" href="${page.url}" aria-label="Goto Page 1">
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
                    <a class="pagination__link" rel="next" href="${response.customData.stencilsPaging.nextUrl}" >
                        <span class="pagination__label">Next</span>
                    </a>
                </div>
            </#if> 
        </nav>
    </section>
</#macro>