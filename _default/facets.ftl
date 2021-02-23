<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
  This template contains markup and logic related to the 
  faceted navigation feature.
-->

<#--
    Generates facets

    @param facets Comma delimited list of facet names to display. If not set all facets are displayed
--->
<#macro Facets facets="">
    <!-- facets.Facets -->
    <#local facetNames = [] />
    <#if facets != "">
        <#local facetNames = facets?split(",") />
    </#if>

    <#-- 
        List the provided names first rather than the facet order, to
        to preserve the order that was passed in 
        -->
    <ul class="module-filter__list">
        <#list facetNames as facetName>
            <#list response.facets![] as facet>
                <#if facetNames?size lt 1  || facetName == facet.name>
                    <#if facet.allValues?size gt 0>
                        <li class="module-filter__item">
                            <span class="module-filter__item-title" aria-haspopup="true" aria-expanded="true"
                                tabindex="0">
                                ${facet.name}
                            </span>

                            <div class="module-filter__facets">
                                <div class="content-wrapper">
                                    <ul class="module-filter__facets-list" role="menu">
                                        <#list facet.allValues as value>
                                            <li class="module-filter__facets-item" role="menuitem">
                                                <#if facet.guessedDisplayType == "RADIO_BUTTON">
                                                    <!-- Radio facets -->
                                                    <a href="${value.toggleUrl!}" class="module-filter__facets-link round ${value.selected?then("active","")}">
                                                        ${value.label} 
                                                        <span>
                                                            ${(value.count)!"0"?string}
                                                        </span>                                                    
                                                    </a>                                                      
                                                <#elseif facet.guessedDisplayType == "CHECKBOX">
                                                    <!-- Checkbox facets -->
                                                    <a href="${value.toggleUrl!}" class="module-filter__facets-link square ${value.selected?then("active","")}">
                                                        ${value.label} 
                                                        <span>
                                                            ${(value.count)!"0"?string}
                                                        </span>
                                                    </a>
                                                <#elseif value.selected>
                                                    <!-- Drilldown facets -->
                                                    <a href="${value.toggleUrl!}" class="module-filter__facets-link ${value.selected?then("active","")}">
                                                        <#if facet.guessedDisplayType == "SINGLE_DRILL_DOWN" && value?counter gt 1>
                                                            <span class="text-muted ml-${value?counter}">&#8627;</span>                                                                                                                        
                                                        </#if>
                                                        ${value.label} 
                                                        (${(value.count)!"0"?string})
                                                    </a>                                                        
                                                <#else>
                                                    <a href="${value.toggleUrl!}" class="module-filter__facets-link square ${value.selected?then("active","")}">
                                                        ${value.label}
                                                        <span>
                                                            ${(value.count)!"0"?string}
                                                        </span>                                                        
                                                    </a>                                                      
                                                </#if>
                                            </li>
                                        </#list>
                                        <#-- 
                                            Display a "Clear all" link except for radio button type facets
                                            as they already have an "all" value 
                                        -->
                                        <#if facet.selected && facet.guessedDisplayType != "RADIO_BUTTON">
                                            <li class="module-filter__facets-item" role="menuitem">
                                                <a class="module-filter__facets-link module-filter__facets-clear_all_link" href="${facet.unselectAllUrl}">
                                                    clear all
                                                </a>
                                            </li>                                        
                                        </#if>                                        
                                    </ul>
                                    <button class="btn-toggle" data-show="3" data-more="+ More" data-less="- Less">
                                        <span class="btn-toggle__text">+ More</span>
                                        <span class="btn-toggle__more">(6)</span>
                                    </button>

                                </div>
                            </div>
                        </li>
                    </#if>
                </#if>
            </#list>
        </#list>
    </ul>                             
</#macro>

<#--
    Display the facet bread crumb which describes the 
    facets/filter options that have been selected by the user
--> 
<#macro FacetBreadBox>
    <!-- facets.FacetsBreadBox -->
    <#if response.facetExtras.hasSelectedNonTabFacets>
        <section class="filter-list search-results__total clearfix">
            <span class="filter-list__title">Selected filters:</span>
            <ul class="filter-list__list">
                <#list response.facets as facet>
                    <#if facet.selected && facet.guessedDisplayType != "TAB">
                        <#list facet.selectedValues as value>
                            <li class="filter-list__item">
                                <a href="${value.toggleUrl}" title="Remove '${facet.name}: ${value.label}'" class="filter-list__link"><span class="sr-only">Clear filter </span><strong>${facet.name}:</strong> ${value.label}</a>
                            </li>
                        </#list>
                    </#if>
                </#list>
            </ul>
        </section>
    </#if>
</#macro>

<#-- Displays facet catergories in a facet as a dropdown list -->
<#macro DropdownFacet facets=[]>
    <!-- facets.DropdownFacet -->

    <#-- 
        Find all the facets with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facetsToDisplay = (response.facets![])?filter(facet -> 
            (!facets?has_content || facets?seq_contains(facet.name)) 
            && facet.allValues?size gt 0
        )
    >

    <#-- Display the facets as a list -->
    <#list facetsToDisplay as facet>
        <#list facet.allValues>
            <section class="dropdown-list">        
                <span class="sr-only">Refine by ${(facet.name)!}</span>
                <button class="dropdown-list__link js-dropdown-list__link" aria-haspopup="true" aria-expanded="false">
                    <#-- Determine what the label of the dropdown should be -->
                    <#local selectedFacetCategories = facet.allValues?filter(value -> value.selected)>

                    <#if selectedFacetCategories?size gt 0>
                        <#-- Display all the selected facet categories as the label -->
                        <span>${(selectedFacetCategories?map(value -> value.label)?join(", "))!}</span>
                    <#else>
                        <#-- Display the facet name as the label -->
                        <span>${(facet.name)!}</span>
                    </#if>                    
                </button>
                <ul class="dropdown-list__list" role="listbox" tabindex="-1"> 
                    <#items as value>
                        <li role="option">
                            <a class="dropdown-list__list-link" title="Refine by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}${value.toggleUrl!}">
                                <#if (value.selected)!false>
                                    <i class="fas fa-check"></i>
                                </#if>
                                ${value.label!}
                            </a>                         
                        </li>
                    </#items>          
                </ul>
            </section>  
        </#list>
    </#list> 
</#macro>

<#-- 
    Displays all available facet categories available for a facets
    as a persistent list. It is intended to be used to display an 
    A-Z index for browsing documents such as services (in a directory
    of service) or programs in a Program Finder.
-->
<#macro ListFacets facets=[]>
    <!-- facets.ListFacets -->
    
    <#-- 
        Find all the facets with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facetsToDisplay = (response.facets![])?filter(facet -> 
            (!facets?has_content || facets?seq_contains(facet.name)) 
            && facet.allValues?size gt 0
        )
    >
    
    <#-- Display the facets as a list -->
    <#list facetsToDisplay as facet>
        <#list facet.allValues>
            <ul class="module-az__list">        
                <span class="sr-only">Refine by ${(facet.name)!}</span> 
                <#items as value>
                    <li class="module-az__item ${value.selected?then("active","")}">
                        <#if value.count gt 0>                        
                            <a href="${question.collection.configuration.value("ui.modern.search_link")}${value.toggleUrl!}" 
                                class="module-az__link"
                                title="Refine by ${value.label!} which has about ${(value.count)!"0"?string} results"
                            >
                                ${(value.label)!} 
                                <span class="sr-only">Refine by</span> 
                            </a>
                        <#else>
                            <span>
                                ${(value.label)!}                         
                            </span>
                        </#if>
                    </li>
                </#items>          
            </ul>
        </#list>
    </#list>
</#macro>

<#macro ClearAllFacets>
    <!-- facets.ClearAllFacets -->
    <#if (response.facetExtras.hasSelectedNonTabFacets)!>
        <a href="${(response.facetExtras.unselectAllFacetsUrl)!}"
        class="search-results__tools-link highlight">Clear all filters</a>
    </#if>
</#macro>

<#-- Run the nest code if the list of specified facets have at least one facet category -->
<#macro HasFacets facets="">
    <#if facets?split(",")?filter( x -> response.facets?filter(y -> x == y.name && y.allValues?size gt 0)?size gt 0)?size gt 0>
        <#nested>
    </#if>
</#macro>

<#-- Runs the nested code only when a certain facet is selected -->
<#macro IsSelected facetName="" categoryLabels=[]>
    <#if !facetName?has_content || !categoryLabels?has_content>   
        <#-- 
            By default, we want to run the nested code if no valid
            configurations are supplied.
        -->
        <#nested>
    <#elseif (response.facets![])?filter(facet -> facet.name?upper_case == facetName?upper_case && facet.selectedValues?filter(category -> categoryLabels?filter(value -> value?upper_case == category.label?upper_case)?size gt 0)?size gt 0)?size gt 0>
        <#-- 
            Given that valid configurations are supplied, we ony 
            want to show the nested content of the facet has been selected.
        -->
        <#nested>
    </#if>
</#macro>


<#-- Runs the nested code only when a certain facet is selected -->
<#macro IsNotSelected facetName="" categoryLabel="">
    <#-- 
        Show the nested content only whent he supplied facet category
        has not been selected
    -->
    <#if (response.facets![])?filter(facet -> facet.name?upper_case == facetName?upper_case && facet.selectedValues?filter(category -> category.label?upper_case == categoryLabel?upper_case)?size gt 0)?size == 0>
        <#nested>
    </#if>
</#macro>
