<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />

<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result=result view="LIST">
  <#switch view?upper_case>
    <#case "CARD">
      <@CardView result=result />
      <#break>
    <#case "LIST">
      <#-- Determine if results should be hidden or not -->
      <@ListView result=result />
      <#break>
    <#default>
      <@ListView result=result />
  </#switch>
</#macro>

<#--
  Stardard view of a result which is to be displayed in the 
  main section of the search engine result page (SERP)
  @param result An individual result fron the data model
-->
<#macro ListView result>
  <@GenericView result=result cardClass="fb-card--list" />
</#macro>

<#--
  Card view of a result which is to be displayed in the 
  main section of the search engine result page (SERP)
  @param result An individual result fron the data model
-->
<#macro CardView result>
  <@GenericView result=result cardClass="fb-card--fixed" />
</#macro>

<#--
  A generic view used to drive both the the list and card view
  @param result An individual result fron the data model
-->
<#macro GenericView result cardClass="fb-card--fixed">
  <li class="search-result search-result-job">
    <div class="card ${cardClass!''}">
 
      <div class="card-body fb-card__body ">        

        <#-- Header section usually containing a title and small thumbnail -->
        <div class="fb-card__header mb-3">
          <div class="fb-card__header__image">
            <#if (result.listMetadata["image"][0])!?has_content>
              <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"][0]}"> 
            <#else>
              <img class="rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/40x40?${(result.listMetadata["jobCompanyName"][0])!}"> 
            </#if>
          </div>

          <div class="fb-card__header__title">
            <div class="card-title">          
              <#if (result.listMetadata["jobPositionTitle"][0])!?has_content>
                <h5>
                  <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                    <@s.boldicize>
                      <@s.Truncate length=90>
                        ${(result.listMetadata["jobPositionTitle"][0])!}
                      </@s.Truncate>
                    </@s.boldicize>
                  </a>
                </h5>            
              </#if>
            </div>
          </div>
        </div>
        
        <#--  <img class="card-img-top" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/344x100?${(result.listMetadata["jobCompanyName"][0])!},marketing">  -->

        <#-- Summary section containing the description and key details of the document -->
        <div class="fb-card__summary">
          <#if (result.listMetadata["jobCompanyName"][0])!?has_content> 
            <div class="card-text">
              <div class="mb-1"> ${(result.listMetadata["jobCompanyName"][0])!} </div>
              <p class="text-muted small truncate-text">
                <span class="fas fa-fw fa-map-marker-alt"></span>
                ${(result.listMetadata["jobLocation"][0])!}
              </p>
            </div>
          </#if>

          <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>
                <@s.Truncate length=170>
                  ${result.summary!?no_esc}
                </@s.Truncate>
              </@s.boldicize>
            </p>
          </div>

          <#if (result.metaData["jobPosted"])!?has_content>
            <div class="card-text mb-3">
              <div class="small">
                <span>
                  Posted: 
                </span>
                <span class="text-muted">
                  ${result.metaData["jobPosted"]!}
                </span>
              </div>
            </div>
          </#if>

          <div class="card-text">
            <@history_cart.LastVisitedLink result=result/>
          </div>
        </div>   
        
        <#-- Additional information such as metadata -->
        <div class="fb-card__additional-info">
          <hr class="mt-3 mb-3" />

          <div class="card-text">
            <p class="small text-muted">
              Additional information
            </p>

            <span class="badge badge-pill badge-light">
              $${rand(50,99)},000
            </span>


            <#if (result.listMetadata["jobType"][0])!?has_content>
              <span class="badge badge-pill badge-light">
                ${result.listMetadata["jobType"][0]!}
              </span>
            </#if> 

            <#--  <span class="badge badge-pill badge-light">
              something else
            </span>    

            <span class="badge badge-pill badge-light">
              another thing
            </span>      -->
          </div>
        </div>

          <#--  <#if (result.metaData["jobSalary"])!?has_content>
            <div>
              <span class="text-muted">
                ${result.metaData["jobSalary"]!}
              </span>
            </div>
          </#if>   -->

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >APPLY</a>
        </div>

      </div>
    </div>
  </li>
</#macro>


<#macro CartTemplate>
  <script id="cart-template-membership-association-jobs-web" type="text/x-handlebar-template">
    <div class="card mb-3">
      <div class="card-body">
        <#-- Title -->
        <div class="card-title">    
          <h4>
            <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>
            <a href="{{indexUrl}}">
              {{#if metaData.jobPositionTitle}} 
                {{metaData.jobPositionTitle}}  
              {{/if}}
            </a>

            {{#if metaData.jobType}}                 
              <span class="text-muted small">
                ({{metaData.jobType}})
              </span>
            {{/if}}
          </h4>
        </div>

        <#-- Card subtitle -->
        {{#if metaData.jobCompanyName}}
          <div class="card-subtitle">
            {{metaData.jobCompanyName}}  
          </div>        
        {{/if}}

        <#-- Location -->
        {{#if metaData.jobLocation}}
          <div class="card-text text-muted small">
            {{metaData.jobLocation}}  
          </div>        
        {{/if}}


        <div class="card-text clearfix mt-3">          
          <#-- TODO - metadata coud have multiple values. Need to add logic to split and take the first one
            {{#if metaData.image}}            
              <img class="img-fluid float-right ml-3 mb-3" alt="Thumbnail for {{title}}" src="https://jobs.ama.org{{metaData.image}} />"> 
            {{/if}}  
          -->

          {{#if summary}}
            <p>
              {{#truncate 255}}
                {{summary}}
              {{/truncate}}
            </p>
          {{/if}}

          {{#if metaData.jobSalary}}
            <div class="card-text text-muted small">
              <span class="text-muted">
                {{metaData.jobSalary}}  
              </span>
            </div>        
          {{/if}}
        </div>        

        {{#if metaData.jobPosted}}
          <div class="card-text">
            <div class="text-right small">
              <span>
                Posted: 
              </span>
              <span class="text-muted">
                {{metaData.jobPosted}}  
              </span>
            </div>
          </div>
        {{/if}}
      </div>
    </div>
  </script>
</#macro>

<#--
* Generates a "random" integer between min and max (inclusive)
*
* Note the values this function returns are based on the current
* second the function is called and thus are highly deterministic
* and SHOULD NOT be used for anything other than inconsequential
* purposes, such as picking a random image to display.
-->
<#function rand min max>
  <#local now = .now?long?c />
  <#local randomNum = _rand +
    ("0." + now?substring(now?length-1) + now?substring(now?length-2))?number />
  <#if (randomNum > 1)>
    <#assign _rand = randomNum % 1 />
  <#else>
    <#assign _rand = randomNum />
  </#if>
  <#return (min + ((max - min) * _rand))?round />
</#function>
<#assign _rand = 0.36 />