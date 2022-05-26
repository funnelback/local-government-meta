<#ftl encoding="utf-8" output_format="HTML" />
<#--  TODO - Update to suit the new design system  -->

<#-- 
  This template contains markup and logic related to the 
  providing the ability for users to browse documents 
  instead of searching. 
-->

<#-- 
    Show the browse mode only on certain tabs.
    Each tab will have a different default sort option. 
    - Title for services
    - Date for social media
-->
<#macro AZToggle>
    <!-- a-z_listing::AZToggle -->
    <#-- Check to see if browse mode config has been setup for the current selected tab -->
    <#if (question.getCurrentProfileConfig().get("stencils.tabs.a-z_listing.facets.${(response.customData.stencils.tabs.selected)!}"))!?has_content>
        <#switch (question.inputParameters["a-z_listing"]?first)!?upper_case>
            <#case "TRUE">
            <#case "ON">
            <#case "1">
                <#break>
            <#default>
                <@AZToggleOn />
        </#switch>
    </#if>
</#macro>

<#-- Provides the user an option to turn the browse mode off -->
<#-- TODO - Come up with a UX for toggling off browse mode -->
<#macro AZToggleOff>
    <!-- a-z_listing::AZToggleOff -->            
    <#-- 
        Output the controls to toggle browse mode from on to off 
        TODO - Need to decide how to handles the users query. Do we 
        retain it or do we do something else?
    -->
    <#--  
        <a class="btn--link" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["a-z_listing", "start_rank","query"])}}">
            Back to search view                        
        </a>  
    -->
</#macro>

<#-- Provides the user an option to turn the browse mode on -->
<#macro AZToggleOn id="fb-browse-mode">
    <!-- a-z_listing::AZToggleOn -->
    <#-- Output the controls to toggle browse mode from off to on -->
    <section class="curator" role="complementary" aria-labelledby="${id}">
        <h2 id="${id}" class="sr-only">Toggle browse mode controls</h2>
        <article class="module-curator__list">
            <article class="listing-item listing-item--promoted listing-item--background-grey10 listing-item--color-black">
                <div class="listing-item__content">                                    
                    <div class="listing-item__header">
                        <h3 class="module-curator__title">
                            <#-- 
                                TODO - Update this section to include an appropriate title 
                            --> 
                            Directory of services
                        </h3>
                    </div>                    
                    <div class="listing-item__body">
                        <#-- Output the description -->
                        <div class="listing-item__summary">
                            <#-- 
                                TODO - Update this section to include the 
                                appropriate message or description (if required)
                            -->                        
                            We are responsible for providing a range of high quality services. 
                            Our residents are at the heart of the services we offer.
                        </div>
                        <#-- Output and option explicit the call to action link -->                    
                        <#local defaultQuery = (question.getCurrentProfileConfig().get("stencils.tabs.a-z_listing.default_query"))!"">

                        <a class="listing-item__action" href="${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, ["a-z_listing", "start_rank", "query","sort"])}&a-z_listing=true&s=${defaultQuery}&sort=title">
                            <#-- 
                                TODO - Update this section to include an appropriate 
                                name for the link. 
                            --> 
                            Browse all our services
                        </a>
                    </div>
                </div>                    
            </article>
        </article>
    </section>    
</#macro>

<#-- 
    Outputs the facets which are associated with browsing a 
    list of documents 
-->
<#macro AZListingFilter>
    <!-- a-z_listing::AZListingFilter -->
    <#switch (question.inputParameters["a-z_listing"]?first)!?upper_case>
        <#case "TRUE">
            
            <#-- Get the list of list facets to be displayed which has been configured by the user -->               
            <#local listFacets = (question.getCurrentProfileConfig().get("stencils.tabs.a-z_listing.facets.${(response.customData.stencils.tabs.selected)!}"))!?split(",")![]>
            
            <#-- Only print the browse mode filter when it has been configured. -->
            <#if listFacets?filter(x -> x != "")?size gt 0>
                <#-- 
                    TODO - Currently this can be hardcoded for each implementation.
                    Determine if is needed to make this configurable.
                -->
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
                <h2>Browse by:</h2>                
                <@facets.ListFacets facets=listFacets />
            </#if>
            <#break>
        <#default>        
    </#switch>
</#macro>