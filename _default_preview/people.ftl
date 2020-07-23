<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to LIST.
-->
<#macro Result result=result view="DETAILED">
  <#switch view?upper_case>
    <#case "CARD">
      <@CardView result=result />
      <#break>
    <#case "LIST">
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
  <li class="search-result search-result-people">
    <div class="card ${cardClass!''}">
 
      <div class="card-body fb-card__body ">        
        <#-- Header section usually containing a title and small thumbnail -->
        <div class="fb-card__header mb-3">
          <div class="fb-card__header__image">
            <#if (result.listMetadata["image"][0])!?has_content>
              <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${result.listMetadata["image"][0]}"> 
            <#else>
              <img class="rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/40x40?${(result.title)!''?url}"> 
            </#if>
          </div>

          <div class="fb-card__header__title">
            <div class="card-title">          
              <#if (result.listMetadata["peopleFirstName"][0])!?has_content || (result.listMetadata["peopleLastName"][0])!?has_content>
                <h5>
                  <#--  <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>  -->
                  <a href="${result.clickTrackingUrl!}" title="${result.title!}">
                    <@s.boldicize>
                      <@s.Truncate length=90>
                        ${(result.listMetadata["peopleFirstName"][0])!} ${(result.listMetadata["peopleLastName"][0])!}
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
          <#if (result.listMetadata["peopleCompany"][0])!?has_content || (result.listMetadata["peopleRole"][0])!?has_content>
            <div class="card-text mb-1">
              ${(result.listMetadata["peopleRole"][0])!?capitalize} at ${(result.listMetadata["peopleCompany"][0])!}
            </div>
          </#if>

           <#if (result.listMetadata["peopleLocation"][0])!?has_content>
            <div class="cart-text text-muted small truncate-text mb-1">
              <span class="fas fa-fw fa-map-marker-alt text-muted"></span>
              <a class="text-muted" href="https://maps.google.com/?q=${(result.listMetadata["peopleLocation"][0])!?url}" target="_blank" title="Show '${(result.listMetadata["peopleLocation"][0])!}' in Google maps">${(result.listMetadata["peopleLocation"][0])!}</a>
            </div>
          </#if>

          <#-- Query biased summary -->
          <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>
                <@s.Truncate length=200>
                  ${result.summary!?no_esc}
                </@s.Truncate>
              </@s.boldicize>
            </p>
          </div>

          <#-- Placeholder text for the summary of a person -->
          <#--  <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
              </@s.boldicize>
            </p>
          </div>  -->

          <div class="card-text">
            <@history_cart.LastVisitedLink result=result/>
          </div>
        </div>   

        <#-- Additional information such as metadata -->
        <div class="fb-card__additional-info">
          <hr class="mt-3 mb-3" />

          <div class="card-text">
            <p class="small text-muted">
              Contact details
            </p>
            
            <#-- The card design supports up to 3 metadata fields -->
            <#if (result.listMetadata["peoplePhone"][0])!?has_content>
              <p class="text-muted truncate-text">
                <span class="fas fa-phone mr-3" title="Job"></span>
                <span class="fb-job__email truncate-text">
                  ${(result.listMetadata["peoplePhone"][0])!?capitalize}
                </span>
              </p>
            </#if>

            <#if (result.listMetadata["peopleEmail"][0])!?has_content>
              <p class="text-muted truncate-text">
                <span class="fas fa-envelope mr-3" title="Job"></span>
                <span class="fb-job__email truncate-text">
                  ${(result.listMetadata["peopleEmail"][0])!?capitalize}
                </span>
              </p>
            </#if>

            <#--  <#if (result.listMetadata["peopleLocation"][0])!?has_content>
              <p class="text-muted truncate-text">
                <span class="fas fa-map-marker-alt mr-3" title="Job"></span>
                <span class="fb-job__email truncate-text">
                  ${(result.listMetadata["peopleLocation"][0])!?capitalize}
                </span>
              </p>
            </#if>  -->
          </div>
        </div>

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >CONTACT</a>
        </div>

      </div>
    </div>
  </li>
</#macro>

<#--
  Handlebars template for concierge
#-->
<#macro AutoCompleteTemplate>
  <script id="auto-completion-people" type="text/x-handlebar-template">
    <div class="fb-auto-complete--non-organic">
      {{#if extra.disp.metaData.image}}
        <img class="rounded-circle fb-auto-complete__primary_visual" src="{{extra.disp.metaData.image}}" alt="{{extra.disp.title}}" />
      {{/if}}
      <div class="fb-auto-complete--non-organic__body">
        <h6 class="fb-auto-complete__body__primary-text">{{extra.disp.metaData.peopleFirstName}} {{extra.disp.metaData.peopleLastName}}</h6>
        <div class="fb-auto-complete__body__metadata text-muted">
          <span class="text-capitalize">{{extra.disp.metaData.peopleRole}}</span>
          {{#if extra.disp.metaData.peopleCompany}}
            at 
            <span class="text-capitalize">{{extra.disp.metaData.peopleCompany}}</span>
          {{/if}}

          {{#if extra.disp.metaData.peopleEmail}}
            <div class="fb-auto-complete__body__metadata text-muted">
              <small>
                <span class="far fa-fw fa-envelope text-muted" aria-hidden="true"></span> 
                {{extra.disp.metaData.peopleEmail}}
              </small>
            </div>
          {{/if}}
        </div>
      </div>
    </div>
  </script>
</#macro>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
