<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
    This file contains the project specific implementation for individual sections
    of the Search Engine Results Page (SERP). Sections include things such as 
    search form, results section, facets and tabs. More often than not,
    this will involve calling macros from other libraries with specific parameters. 
-->

<#macro SearchForm>
    <section class="module-search js-module-search content-wrapper module-search--bg" style="background-image: url('/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/bg-search.png');">
        <h2 class="sr-only">Search module</h2>
        <@base.SearchForm>
            <div class="module-search__group">
                <input type="hidden" name="collection" value="program-finder-meta">
                <label for="query" class="sr-only">Search</label>
                <input required name="query" id="query" type="Search query" autofocus class="module-search__query tt-input" autocomplete="off" placeholder="Start your search here…" value="${question.query!}" spellcheck="false" dir="auto"">

                <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>                
            </div>
        </@base.SearchForm>
    </section>


    <#-- Enable the cart and history button  -->
    <#--  
    <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
            <ul class="float-right list-inline">
                    <li class="list-inline-item">
                            <button type="button" tabindex="0" class="btn btn-link">
                                    <small>
                                            <span class="flb-cart-count"></span>
                                    </small>
                            </button>
                    </li>
                    <li class="list-inline-item">
                            <button type="button" tabindex="0" class="btn btn-link session-history-toggle">
                                    <small>
                                            <span class="fas fa-history"></span>
                                            History
                                    </small>
                            </button>
                    </li>
            </ul>
    </#if>  
    -->

    <#-- Hiding recent queries until it as been factored into the design
        <@history_cart.RecentQueries />
    -->
</#macro>

<#macro Tabs>
    <@tabs.Tabs />
</#macro>

<#-- Outputs the search result section -->
<#macro Results>
    <div>
        <section id="search-results" class="search-results">
            <@facets.FacetBreadBox />

            <@base.Blending />
            <#-- 
                Only display the search tools such as sorting when there
                are at least 1 result 
            -->
            <#if ((response.resultPacket.resultsSummary.totalMatching)!0) != 0>
                <@base.SearchTools />            
            </#if> 
            
            <@curator.BestBets />                
            <@curator.Curator position="center" />      

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

            <@curator.Curator position="bottom" />

            <@base.Paging />

            <@contextual_navigation.ContextualNavigation />

        </section>

        
        <@history_cart.Cart />
        <@history_cart.SearchHistory />

    </div>
</#macro>

<#-- Display the facets based on the configurations -->
<#macro Facets>
    <#local tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${(response.customData.stencilsTabsSelectedTab)!}")!>

    <div>
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
    </div>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
