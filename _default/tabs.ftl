<#-- Not to be used in production -->

<#-- This file should be replaced by a copy of the Stencils file when
    deploying, to allow customization. Explicitly fail if the collection is not
    the showcase collection. To fix it, copy the file from
    $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
    question.collection.id == 'membership-association-meta' >
    <#include "/share/stencils/libraries/tabs/tabs.ftl">
<#else>
    <#-- Create a dummy version of a tabs.ftl macro, as a way to display
        the error message -->
    <#macro Tabs>
        <div class="alert alert-danger">
            <p><code>tabs.ftl</code> is currently directly including the Stencils
            file. This is discouraged as Stencils changes will break the collection
            templates. Please make a copy of <code>tabs.ftl</code> instead, from the
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
    defining <#macro SomeMacro>. 
--> 

<#--
    Display tabs
    @param facets List of tabs to display as a string. The default is that all tabs
        will be displayed
-->
<#macro Tabs tabs=[]>
    <!-- tabs.Tabs -->

    <#-- 
        Find all the tabs with values and determine if we want to display all tabs or just the tabs specified 
    -->
    <#local facets = (response.facets![])?filter(facet -> 
            facet.guessedDisplayType == "TAB"
            && facet.allValues?size gt 0
            && (!tabs?has_content || tabs?seq_contains(facet.name))
        )
    >

    <#list facets![] as facet>
        <section class="tabs js-tabs content-wrapper">
            <ul class="tabs__list" role="menu" aria-label="Tab navigation">
                <#list facet.allValues as value>
                    <#if value?counter lt (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number> 
                        <li class="tabs__item" role="none">
                            <a <#if value.count gt 0>href="${value.toggleUrl}"</#if> 
                                class="tabs__link tabs__link--icon <#if value.selected> active</#if><#if value.count lt 1> tabs__link--disabled </#if>"
                                role="menuitem"
                                tabindex="-1">
                                <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                                    <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                                </#if>                            
                                ${value.label}
                                <span>(${value.count})</span>
                            </a>
                        </li>
                    </#if>
                </#list>                                        

                <#-- Collapse the remaining tabs into a drop down -->
                <#if facet.allValues?size gte (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number>              
                    <li class="tabs__item dropdown">
                        <span class="dropdown__toggle" href="#" >
                            
                            <#-- Determine if a tab is the more dropdown has been selected -->
                            <#assign maxDisplay = (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number>
                            <#assign noTabs = facet.allValues?size>
                            <#assign isMoreTabSelected = false>

                            <#if facet.allValues?sequence[maxDisplay-1..noTabs - 1]?filter(value -> value.selected)?size gt 0>
                                <#assign isMoreTabSelected = true>
                            </#if>
                            
                            <a class="tabs__link <#if isMoreTabSelected>active</#if>" href="#" aria-haspopup="true" aria-expanded="false" id="tabDropdown">
                                More
                            </a>

                            <#-- Display the additional tabs as a dropdown menu -->
                            <ul class="dropdown_menu" aria-labelledby="tabDropdown">
                                <#list facet.allValues as value>
                                    <#if value?counter gte (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number>
                                        <li class="dropdown__item <#if value.selected>active</#if><#if value.count lt 1>disabled</#if>">                
                                            <a title="Refine by ${value.label}" <#if value.count gt 0>href="${value.toggleUrl}"</#if>>
                                                <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                                                    <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                                                </#if>
                                                ${value.label!} <span class="search-facet-count">(${value.count})</span>
                                            </a>
                                        </li>
                                    </#if>
                                </#list>
                            </ul>
                        </span>
                    </li>                          
                </#if>
            </ul>
        </section>
    </#list>
</#macro>

<#-- 
    Provides preview of a tab. This allows the user to see 
    a sample of the results on another tab without having to click
    back and forwards. It also improves the user flow by providing
    a link to navigate to the target tab.

    @param extraSearchName The extra search of the documents of the target tab.
    @param documentType The type of documents which is being displayed by
        the extra search.
    @param view Controls how the documents will be presented.
    @param parentQuestion The question containin the tabs facet. This is required
        as extra searches remove facet navigation results. It defaults to the
         global question which is currently in scope.
-->
<#macro Preview extraSearchName documentType="" view="DETAILED" parentQuestion=question>
    <!-- tabs.Preview -->
    <#assign parentQuestion = question>
    <@fb.ExtraResults name=extraSearchName>
        <#if (response.resultPacket.results)!?has_content>
            <div class="search-tab-preview text-muted mb-3">
                <h4>Related ${documentType!}</h4>
                <ol class="list-unstyled">
                    <#list (response.resultPacket.results)![] as result>
                        <@base.Result result=result view=view question=parentQuestion/>
                    </#list>
                </ol>

                <#if (response.customData.stencilsTabsPreviewLink)!?has_content>
                    
                    <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                    <#assign previewLink = response.customData.stencilsTabsPreviewLink!>
                    
                    <a href="${searchLink}${previewLink}" title="See more results for ${tabDisplayName!}">
                        <i class="fas fa-arrow-right mr-1"></i>
                        See more results for ${documentType!} 
                    </a>
                </#if>
            </div>
        </#if>
    </@fb.ExtraResults>
</#macro>

