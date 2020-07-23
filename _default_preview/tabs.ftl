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

<#---
  Display tabs, from the FACETED_NAVIGATION extra search
-->
<#macro Tabs>
  <#list (response.facets)![] as facet>
    <#if facet.allValues?size gt 0 && facet.guessedDisplayType == "TAB">
      <div class="navbar-expand-md navbar-dark text-center pb-3">
        <#-- Button to show filters on mobile -->
        <button class="navbar-toggler mb-3" type="button" data-toggle="collapse" data-target="#search-tabs" aria-expanded="false" aria-label="Toggle tabs">
          <small class="navbar-toggler-icon"></small> Show Filters
        </button>

        <div class="collapse navbar-collapse" id="search-tabs">
          <ul class="nav nav-pills justify-content-center mx-auto w-100">
            <#list facet.allValues as value>
              <#if value?counter lt (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number> 
                <li class="nav-item ml-1 mr-1">
                  <a class="nav-link text-center<#if value.selected> active</#if><#if value.count lt 1> disabled</#if>" <#if value.count gt 0>href="${value.toggleUrl}"</#if>>
                    <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                      <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                    </#if>
                    ${value.label} <span class="search-facet-count">(${value.count})</span>
                  </a>
                </li>
              </#if>
            </#list>

            <#-- Collapse the remaining tabs -->
            <#if facet.allValues?size gte (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number>              
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                  <i class="fas fa-ellipsis-v"></i>
                  More                  
                </a>
                <div class="dropdown-menu">
                  <#list facet.allValues as value>
                    <#if value?counter gte (question.getCurrentProfileConfig().get("stencils.tabs.max_display")!"5")?number>
                      <a class="dropdown-item <#if value.selected> active</#if><#if value.count lt 1> disabled</#if>" <#if value.count gt 0>href="${value.toggleUrl}"</#if>>
                        <#if question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")??>
                          <span class="${question.getCurrentProfileConfig().get("stencils.tabs.icon.${value.label}")}"></span>
                        </#if>
                        ${value.label} <span class="search-facet-count">(${value.count})</span>
                      </a>
                    </#if>
                  </#list>
                </div>
              </li>
            </#if>
          </ul>
        </div>
      </div>
    </#if>
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