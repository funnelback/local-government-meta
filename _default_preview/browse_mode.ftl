<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
  This template contains markup and logic related to the 
  providing the ability for users to browse documents 
  instead of searching. 
-->

<#-- 
    BrowseModeToggle 
    Show the browse mode only on certain tabs.
    Each tab will have a different default sort option. 
    - Title for services
    - Date for social media
-->
<#macro BrowseModeToggle>
    <!-- browse_mode.BrowseModeToggle -->
    <#-- Check to see if browse mode config has been setup for the current selected tab -->
    <#if (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.facets.${(response.customData.stencilsTabsSelectedTab)!}"))!?has_content>
        <#switch (question.inputParameterMap["browse_mode"])!?upper_case>
            <#case "TRUE">
            <#case "ON">
            <#case "1">
                <#break>
            <#default>
                <@BrowseModeToggleOn />
        </#switch>
    </#if>
</#macro>

<#-- Provides the user an option to turn the browse mode off -->
<#macro BrowseModeToggleOff>
    <!-- browse_mode.BrowseModeToggle -->            
    <#-- 
        Output the controls to toggle browse mode from on to off 
        TODO - Need to decide how to handles the users query. Do we 
        retain it or do we do something else?
    -->
    <#--  
        <a class="btn--link" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["browse_mode", "start_rank","query"])}}">
            Back to search view                        
        </a>  
    -->
</#macro>

<#-- Provides the user an option to turn the browse mode on -->
<#macro BrowseModeToggleOn>
    <!-- browse_mode.BrowseModeToggleOn -->
    <#-- Output the controls to toggle browse mode from off to on -->
    <section class="module-curator">
        <h2 class="sr-only">Toggle browse mode controls</h2>
        <article class="module-curator__list">
            <article class="module-curator__item">
                <div class="module-curator__top">                                    
                    <div>
                        <h3 class="module-curator__title">
                            <a href="" class="module-curator__link">
                                Directory of services
                            </a>
                        </h3>
                    </div>
                    
                </div>                    
                <div class="module-curator__content">
                    <#-- Output the description -->
                    <p class="">
                        We are responsible for providing a range of high quality services. Our residents are at the heart of the services we offer.
                    </p>
                </div>
                <#-- Output and option explicit the call to action link -->
                <a class="btn--link" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["browse_mode", "start_rank", "query","sort"])}&browse_mode=true&query=!padrenull&sort=title">
                    View all services
                </a>
            </article>
        </article>
    </section>    
</#macro>

<#-- 
    Outputs the facets which are associated with browsing a 
    list a list of documents 
-->
<#macro BrowseByFilter>
    <!-- browse_mode.BrowseByFilter -->
    <#switch (question.inputParameterMap["browse_mode"])!?upper_case>
        <#case "TRUE">
        <#case "ON">
        <#case "1">
            <section class="module-az">
                <#--                  
                <section class="module-az__filter">
                    I’m a
                    <@facets.DropdownFacet facets=["Radio"] />
                    looking to study in
                    <@facets.DropdownFacet facets=["Date"] />
                    I’m interested in a career in
                    <@facets.DropdownFacet facets=["Format"] /> 
                    . I’d like to study
                    <@facets.DropdownFacet facets=["Format"] />
                </section>  
                -->
                
                <#-- Get the list of list facets to be displayed which has been configured by the user -->
                <#local listFacets = (question.getCurrentProfileConfig().get("stencils.tabs.browse_mode.facets.${(response.customData.stencilsTabsSelectedTab)!}"))!?split(",")![]>
                
                <@facets.ListFacets facets=listFacets />
            </section>
            <#break>
        <#default>        
    </#switch>
</#macro>