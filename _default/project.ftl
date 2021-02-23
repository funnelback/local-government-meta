<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    This file contains the project specific implementation for individual sections
    of the Search Engine Results Page (SERP). Sections include things such as 
    search form, results section, facets and tabs. More often than not,
    this will involve calling macros from other libraries with specific parameters. 
-->

<#macro SearchForm>
    <!-- project.SearchForm -->
    <section class="module-search js-module-search content-wrapper module-search--bg" style="background-image: url('/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/bg-search.png');">
        <h1 class="sr-only">Search module</h1>
        <@base.SearchForm>
            <div class="module-search__group">
                <label id="fb-query"for="query" class="sr-only">Search</label>                
                <input required 
                    name="query" 
                    id="query" 
                    type="Search query" 
                    autofocus 
                    class="module-search__query tt-input" 
                    autocomplete="off" 
                    placeholder="Start your search here…" 
                    value="${question.query!}" 
                    spellcheck="false" 
                    dir="auto"
                    aria-labelledby="fb-query"
                    aria-required="true">

                <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>                

                <@history_cart.Controls />
            </div>
        </@base.SearchForm>
    </section>
</#macro>

<#macro Tabs>
    <@tabs.Tabs tabs=["Tabs"] />
</#macro>

<#-- Outputs the search result section -->
<#macro Results>
    <!-- project.Results -->
    <div>
        <section id="search-results" class="search-results">
            <@facets.FacetBreadBox />

            <@base.Blending />
            
            <@browse_mode.BrowseByFilter />

            <#-- 
                Only display the search tools such as sorting when there
                are at least 1 result 
            -->
            <#if ((response.resultPacket.resultsSummary.totalMatching)!0) != 0>
                <@base.SearchTools />            
            </#if> 
            
            <@curator.BestBets />                
            <@curator.Curator position="center" sectionCss="module-curator--no-bg" />      

            <@base.NoResults />

            <@base.ResultList nestedRank=3>            
                <@fb.ExtraResults name="twitter">
                    <li><h4 class="sr-only">Tweet results</h4></li>
                    <li class="search-results-twitter">
                        <div class="row mb-3">
                            <#list (response.resultPacket.results)![] as result>
                                <#-- Limit to only 3 Twitter cards -->
                                <#if result?index lt 3>
                                    <div class="col-md-4">
                                        <@twitter.TwitterCard result=result />
                                    </div>
                                </#if>
                            </#list>
                        </div>
                    </li>
                </@fb.ExtraResults>
            </@base.ResultList>

            <@curator.Curator position="bottom" sectionCss="module-curator--no-bg" />

            <@base.Paging />

            <@contextual_navigation.ContextualNavigation />

        </section>
    </div>
</#macro>

<#-- 
    Display the results with the ability to browse 
    We want different markup here compared to the standard results.
    e.g. Additional tab at the top
-->
<#-- -->


<#-- Display the facets based on the configurations -->
<#macro SideNavigation>
    <!-- project.SideNavigation -->
    <div>
        
        <@browse_mode.BrowseModeToggle />

        <#-- Get facets for the current selected tab -->
        <#local tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${(response.customData.stencilsTabsSelectedTab)!}")!>
        
        <#-- Display facets -->
        <section class="module-filter module-filter--dark js-module-filter">
            <@facets.HasFacets facets=tabFacets>
                <div class="module-filter__wrapper">
                    
                    <h2 class="module-filter__title">Filter by</h2>
                    <div class="module-filter__wrapper-mobile">
                        <@facets.Facets tabFacets />
                    </div>
                </div>
            </@facets.HasFacets>
        </section>

        <#-- Curator - Left hand side -->
        <section>
            <@curator.Curator position="left" />  
        </section>
    </div>
</#macro>