<#ftl encoding="utf-8" output_format="HTML" />

<#-- Not to be used in production -->

<#-- This file should be replaced by a copy of the Stencils file when
  deploying, to allow customization. Explicitly fail if the collection is not
  the showcase collection. To fix it, copy the file from
  $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
  question.collection.id == 'membership-association-meta' >
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
  <label for="fb-display-control" class="sr-only">Display: </label>
  <div id="fb-display-control" class="btn-group float-right mr-1 fb-search-controls" aria-label="Display controls">
    <button type="button" class="btn btn-light <#if getDisplayMode(question)! == 'LIST'>active</#if>">
      <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=list'
        title="Display results as a list"
      >
        <i class="fas fa-list"></i>
      </a>
    </button>
    <button type="button" class="btn btn-light <#if getDisplayMode(question)! == 'CARD'>active</#if>">
      <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=card'
        title="Display results as cards"
      >
        <i class="fas fa-th"></i>
      </a>
    </button>    
  </div>

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
  <ol class="list-unstyled fb-result-set fb-display-mode--${view?lower_case}">
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
  </ol>
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
  Message to display when there are no results
-->
<#macro NoResults>
  <#if (response.resultPacket.resultsSummary.totalMatching)! == 0>
    <div class="mb-5">
      <h3><i class="fas fa-exclamation-circle"></i> No results</h3>
      <p>Your search for <strong><@s.QueryClean /></strong> did not return any results. Please ensure that you:</p>
      <ul >
        <li>are not using any advanced search operators like + - | " etc.</li>
        <li>expect this document to exist within the <em><@s.cfg>service_name</@s.cfg></em> collection <@s.IfDefCGI name="scope"> and within <em><@s.Truncate length=80>${question.inputParameterMap["scope"]!}</@s.Truncate></em></@s.IfDefCGI></li>
        <li>have permission to see any documents that may match your query</li>
      </ul>
    </div>

    <div class="mb-5">
      <h3>Trending searches</h3>
      <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
        <div class="col-auto d-none d-lg-block">
          <img src="https://www.ama.org/wp-content/themes/ama/assets/images/placeholder-image-small.png" alt="..." width="350">
        </div>
        <div class="col p-4 d-flex flex-column position-static">
          <h4 class="">What other members are looking for</h3>
          <ul>
            <li>
              <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=membership+benefits">
                <span>Membership benefits</span>
              </a>
            </li>
            <li>
              <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=coronavirus+and+the+impacts+on+marketing">
                <span>Coronavirus and the impacts on marketing</span>
              </a>
            </li>
            <li>
              <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=upcoming+events">
                <span>Upcoming events</span>
              </a>
            </li>
          </ul>
        </div>
      </div>      
    </div>

    <div>
      <h3 class="mt-3 mb-3">You could also try</h3>
      <div class="card-deck">
        <div class="card">
          <img src="https://www.ama.org/wp-content/uploads/2020/02/undraw_social-girl.jpg?resize=486%2C365" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Contact Us</h5>
            <div class="card-text">
              Give us a call at 1-800-AMA-1150. Our customer support team is available Monday through Friday, 8:30 a.m. - 5 p.m. CDT.
            </div>
          </div>
        </div>
        <div class="card">
          <img src="https://www.ama.org/wp-content/uploads/2020/02/TS20-Demand-Generation-Website-Card-New.png?resize=486%2C365" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Professional Chapter Leaders</h5>
            <div class="card-text">
              <ul>
                <li><a href="https://myama.force.com/s/article/Codes-of-Conduct"><span>Codes of Conduct</span></a></li>
                <li><a href="https://myama.force.com/s/article/Group-Discount-Program-for-AMA-Membership"><span>Group Discount Program for AMA Membership</span></a></li>
                <li><a href="https://myama.force.com/s/article/AMA-Community-Help"><span>AMA Community Help</span></a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="card">
          <img src="https://www.ama.org/wp-content/uploads/2020/02/WEB_virtue.jpg?resize=486%2C365" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Certification and Training</h5>
            <div class="card-text">
              <ul>
                <li><a href="https://myama.force.com/s/article/How-to-Maintain-Your-Professional-Certified-Marketer-PCM-Certification" >How to Maintain Your Professional Certified Marketer (PCM) Certification and Record CEUs</span></a></li>
                <li><a href="https://myama.force.com/s/article/How-to-access-PCM-certification-exams" >How to access PCM certification exams.</span></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

  </#if>

</#macro>

<#--
  Display Curator messages

  @param position Position attribute to consider from the Curator message.
    Only messages with a position attribute matching this will be displayed. Can be empty to display all messages regardless of position.
-->
<#macro CuratorExhibits position>
  <div class="fb-curator-exhibits row">
    <h3 class="sr-only"> Promoted results </h3>
    <#list (response.curator.exhibits)![] as exhibit>

        <#-- Skip best bets -->
        <#if exhibit.category != "BEST_BETS">
          <#-- Only display if the position specified matches the Curator position.
            Curators with no position set default to "center" -->
          <#if !position?? || ((exhibit.additionalProperties.position)!"center") == position>

            <#if exhibit.messageHtml??>
              <#-- Simple message -->
              <blockquote class="blockquote search-exhibit ${(exhibit.additionalProperties.class)!} mb-3 p-1">
                ${exhibit.messageHtml?no_esc}
              </blockquote>
            <#elseif exhibit.descriptionHtml??>
              <#-- Rich message -->
              <div class="card search-exhibit ${(exhibit.additionalProperties.class)!} mb-3">
                <div class="card-header">
                  <h4><a href="${exhibit.linkUrl!}">${exhibit.titleHtml!}</a></h4>
                </div>
                <div class="card-body">
                  <#if exhibit.displayUrl?? && exhibit.displayUrl != "-"><cite class="text-success">${exhibit.displayUrl}</cite></#if>
                  <#if exhibit.descriptionHtml??>${exhibit.descriptionHtml?no_esc}</#if>
                </div>
              </div>
            </#if>
          </#if>
        </#if>
    </#list>
  </div>
</#macro>