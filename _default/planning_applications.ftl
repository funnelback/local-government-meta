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
  <li class="search-result search-result-job" data-fb-result="${result.indexUrl}">
    <div class="card ${cardClass!''}">
 
      <div class="card-body fb-card__body ">        

        <#-- Header section usually containing a title and small thumbnail -->
        <div class="fb-card__header mb-3">
          <div class="fb-card__header__image">
            <#if (result.listMetadata["image"][0])!?has_content>
              <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"][0]}"> 
            <#else>
              <span class="fas fa-pencil-ruler fb-text-icon-round"></span>
              <#--  <img class="rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/40x40?${(result.listMetadata["planningApplicationName"][0])!}">   -->
            </#if>
          </div>

          <div class="fb-card__header__title">
            <div class="card-title">          
              <#if (result.listMetadata["planningApplicationName"][0])!?has_content>
                <h5>
                  <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                    <@s.boldicize>
                      <@s.Truncate length=90>
                        ${(result.listMetadata["planningApplicationName"][0])!}
                      </@s.Truncate>
                    </@s.boldicize>
                  </a>
                </h5>            
              </#if>
            </div>
          </div>
        </div>
        
        <#-- Summary section containing the description and key details of the document -->
        <div class="fb-card__summary">
          <#if (result.listMetadata["planningWardName"][0])!?has_content> 
            <div class="card-text">
              <div class="mb-1"> ${(result.listMetadata["planningWardName"][0])!} </div>
              <p class="text-muted small truncate-text">
                <span class="fas fa-fw fa-map-marker-alt"></span>
                ${(result.listMetadata["planningDevelopeAddress"][0])!}
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

          <#if (result.metaData["planningRegisteredDate"])!?has_content>
            <div class="card-text mb-3">
              <div class="small">
                <span>
                  Registered: 
                </span>
                <span class="text-muted">
                  ${result.metaData["planningRegisteredDate"]!}
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

            <#if (result.listMetadata["planningSystemStatus"][0])!?has_content>
              <span class="badge badge-pill badge-light">
                ${result.listMetadata["planningSystemStatus"][0]!}
              </span>
            </#if> 

            <#if (result.listMetadata["planningDecisionType"][0])!?has_content>
              <span class="badge badge-pill badge-light">
                ${result.listMetadata["planningDecisionType"][0]!}
              </span>
            </#if> 

            <#if (result.listMetadata["jobType"][0])!?has_content>
              <span class="badge badge-pill badge-light">
                ${result.listMetadata["planningCaseOfficerTeam"][0]!}
              </span>
            </#if> 
          </div>
        </div>

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >VIEW STATUS</a>
        </div>

      </div>
    </div>
  </li>
</#macro>


<#-- 
  Handlebars template used to display the current object
  in concierge.
--> 
<#macro AutoCompleteTemplate>
  <script id="auto-completion-planning_applications" type="text/x-handlebar-template">
    <div class="fb-auto-complete--non-organic">
      {{#if extra.disp.metaData.image}}
        <img class="rounded-circle fb-auto-complete__primary_visual" src="{{extra.disp.metaData.image}}" alt="{{extra.disp.title}}" />
      {{else}}
        <span class="fas fa-pencil-ruler fb-text-icon-round mr-3"></span> 
      {{/if}}
      <div class="fb-auto-complete--non-organic__body">
        <h6 class="fb-auto-complete__body__primary-text">{{extra.disp.metaData.planningApplicationName}}</h6>
        <div class="fb-auto-complete__body__metadata text-muted">
          <#--  <span class="text-capitalize">{{extra.disp.metaData.peopleRole}}</span>  -->
          {{#if extra.disp.metaData.planningWardName}}
            <span class="text-capitalize">{{extra.disp.metaData.planningWardName}}</span>
          {{/if}}

          {{#if extra.disp.metaData.planningDevelopeAddress}}
            <div class="fb-auto-complete__body__metadata text-muted">
              <small>
                <span class="fas fa-map-marker-alt text-muted" aria-hidden="true"></span> 
                {{extra.disp.metaData.planningDevelopeAddress}}
              </small>
            </div>
          {{/if}}

          {{#if extra.disp.metaData.planningRegisteredDate}}
            <div class="fb-auto-complete__body__metadata text-muted">
              <small>
                <span class="fas fa-calendar-alt text-muted" aria-hidden="true"></span> 
                Registered on {{extra.disp.metaData.planningRegisteredDate}}
              </small>
            </div>
          {{/if}}
        </div>
      </div>
    </div>
  </script>
</#macro>