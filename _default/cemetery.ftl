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
              <span class="fas fa-id-badge fb-text-icon-round"></span>
              <#--  <img class="rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/40x40?${(result.listMetadata["cemeterySurname"][0])!},${(result.listMetadata["cemeteryFirstName"][0])!}">   -->
            </#if>
          </div>

          <div class="fb-card__header__title">
            <div class="card-title">          
              <#if (result.listMetadata["cemeterySurname"][0])!?has_content || (result.listMetadata["cemeteryFirstName"][0])!?has_content>
                <h5>
                  <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                    <@s.boldicize>
                      <@s.Truncate length=90>
                        ${(result.listMetadata["cemeterySurname"][0])!}, ${(result.listMetadata["cemeteryFirstName"][0])!}
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
          <#if (result.listMetadata["cemeteryCemetery"][0])!?has_content> 
            <div class="card-text">
              <#--  <div class="mb-1"> ${(result.listMetadata["cemeteryCemetery"][0])!} </div>  -->
              <p class="text-muted small truncate-text">
                <span class="fas fa-fw fa-map-marker-alt"></span>
                ${(result.listMetadata["cemeteryCemetery"][0])!}
              </p>
            </div>
          </#if>

          <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>              
                  Passed away
                    <#if (result.listMetadata["cemeteryDateDied"][0])!?has_content>
                      on ${(result.listMetadata["cemeteryDateDied"][0])!}
                    </#if> 
                  
                  <#if (result.listMetadata["cemeteryAge"][0])!?has_content &&
                  (result.listMetadata["cemeteryAge"][0])!?upper_case != "0">
                    at the age of ${(result.listMetadata["cemeteryAge"][0])!} 
                    ${(result.listMetadata["cemeteryAgeUnit"][0])!} 
                  </#if> 

                  <#if (result.listMetadata["cemeteryCemetery"][0])!?has_content> 
                    <br />
                    Burried at ${(result.listMetadata["cemeteryCemetery"][0])!} 
                    <#if (result.listMetadata["cemeteryDateBuried"][0])!?has_content> 
                      on  ${(result.listMetadata["cemeteryDateBuried"][0])!} 
                    </#if>
                  </#if>
              </@s.boldicize>
            </p>
          </div>

          <div class="card-text">
            <@history_cart.LastVisitedLink result=result/>
          </div>
        </div>   
        
        <#-- Additional information such as metadata -->
        <#--  <div class="fb-card__additional-info">
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

            <span class="badge badge-pill badge-light">
              something else
            </span>    

            <span class="badge badge-pill badge-light">
              another thing
            </span>
          </div>
        </div>  -->

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >SHOW ON MAP</a>
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
  <script id="auto-completion-cemetery" type="text/x-handlebar-template">
    <div class="fb-auto-complete--non-organic">
      {{#if extra.disp.metaData.eventImage}}
        <img class="rounded-circle fb-auto-complete__primary_visual" src="{{extra.disp.metaData.eventImage}}" alt="{{extra.disp.title}}" />
      {{else}}
        <span class="fas fa-id-badge fb-text-icon-round mr-3"></span> 
      {{/if}}
      <div class="fb-auto-complete--non-organic__body">
        <h6 class="fb-auto-complete__body__primary-text">
          {{extra.disp.metaData.cemeterySurname}}, {{extra.disp.metaData.cemeteryFirstName}}
        </h6>

        <div class="fb-auto-complete__body__metadata text-muted">
          
          Passed away on
          {{#if extra.disp.metaData.cemeteryDateDied}}
            {{extra.disp.metaData.cemeteryDateDied}}
          {{/if}}        

          {{#if extra.disp.metaData.cemeteryAge}}
            at the age of
            {{extra.disp.metaData.cemeteryAge}}
            {{extra.disp.metaData.cemeteryAgeUnit}}
          {{/if}}  

          {{#if extra.disp.metaData.cemeteryCemetery}}
            <div>
              Burried at {{extra.disp.metaData.cemeteryCemetery}}
            </div>
          {{/if}}              
        </di v>
    </div>    
  </script>
</#macro>

