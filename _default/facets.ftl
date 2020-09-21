<#ftl encoding="utf-8" output_format="HTML" />

<#-- This file should be replaced by a copy of the Stencils file when
    deploying, to allow customization. Explicitly fail if the collection is not
    the showcase collection. To fix it, copy the file from
    $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
    question.collection.id == 'membership-association-meta' ||
    question.collection.id == 'local-government-meta'  >
    <#include "/share/stencils/libraries/facets/facets.ftl">
<#else>
    <#-- Create a dummy version of a facets.ftl macro, as a way to display
        the error message -->
    <#macro SelectedFacetValues>
        <div class="alert alert-danger">
            <p><code>facets.ftl</code> is currently directly including the Stencils
            file. This is discouraged as Stencils changes will break the collection
            templates. Please make a copy of <code>facets.ftl</code> instead, from the
            Stencils sources (<code>$SEARCH_HOME/share/stencils/libraries/</code>).</p>

            <p>Subsequent template processing will fail until this is fixed.</p>
        </div>
    </#macro>
</#if>


<#--
    Generates facets

    @param facets Comma delimited list of facet names to display. If not set all facets are displayed
--->
<#macro Facets facets="">
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

                                <#-- Display a "Clear all" link except for radio button type facets
                                    as they already have an "all" value -->
                                <#if facet.selected && facet.guessedDisplayType != "RADIO_BUTTON">
                                    <a class="text-muted" href="${facet.unselectAllUrl}">
                                        <small>
                                            <span class="fas fa-times"></span>
                                            clear all
                                        </small>
                                    </a>
                                </#if>
                            </span>

                            <div class="module-filter__facets" style="display: block;">
                                <div class="content-wrapper">
                                    <ul class="module-filter__facets-list" role="menu">
                                        <#list facet.allValues as value>
                                            <li class="module-filter__facets-item" role="menuitem">
                                                <#if facet.guessedDisplayType == "RADIO_BUTTON">
                                                    <i class="fb-sidebar__facet-icon align-middle text-muted ${value.selected?then("fas fa-circle", "far fa-circle")}"></i>
                                                <#elseif facet.guessedDisplayType == "CHECKBOX">
                                                    <i class="fb-sidebar__facet-icon align-middle text-muted ${value.selected?then("fas fa-check-square", "far fa-square")}"></i>
                                                <#elseif value.selected>
                                                    <#if facet.guessedDisplayType == "SINGLE_DRILL_DOWN" && value?counter gt 1>
                                                        <span class="text-muted ml-${value?counter}">&#8627;</span>
                                                    </#if>
                                                    <i class="fb-sidebar__facet-icon align-middle text-muted fas fa-times"></i>
                                                </#if>

                                                <a href="${value.toggleUrl!}" class="module-filter__facets-link">
                                                    ${value.label} (${(value.count)!"0"?string})
                                                </a>
                                            </li>
                                        </#list>
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

<#macro HasFacets facets="">
    <#if facets?split(",")?filter( x -> response.facets?filter(y -> x == y.name && y.allValues?size gt 0)?size gt 0)?size gt 0>
        <#nested>
    </#if>
</#macro>