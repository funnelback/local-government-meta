<#ftl encoding="utf-8" output_format="HTML" />
<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result view="LIST">
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
  <li class="search-result search-result-event" data-fb-result="${result.indexUrl}">
    <div class="card ${cardClass!''}">
 
      <#if (result.listMetadata["eventImage"][0])!?has_content>
        <img class="card-img-top deferred" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${(result.listMetadata['eventImage'][0])!}" /> 
      <#else>
        <img class="card-img-top" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/335x192?${(result.title)!''?url}"> 
      </#if>


      <div class="card-body fb-card__body">        
        
        <#--  <img class="card-img-top" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/344x100?${(result.listMetadata["jobCompanyName"][0])!},marketing">  -->

        <#-- Summary section containing the description and key details of the document -->
        <div class="fb-card__summary">
          <div class="card-title">          
            <#if (result.title)!?has_content>
              <h5>
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                  <@s.boldicize>
                    <@s.Truncate length=90>
                      ${(result.title)!}
                    </@s.Truncate>
                  </@s.boldicize>
                </a>
              </h5>            
            </#if>
          </div>

          <#if (result.listMetadata["eventLocation"][0])!?has_content> 
            <div class="card-text">
              <div class="mb-1"> ${(result.listMetadata["eventLocation"][0])!} </div>
            </div>
          </#if>

          <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>
                ${result.summary!?no_esc}
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
        <#if (result.listMetadata["eventPricingStandardMember"][0])!?has_content || 
        (result.listMetadata["eventPricingStandardNonMember"][0])!?has_content>
          <div class="fb-card__additional-info">
            <hr class="mt-3 w-100" /> 
            <div class="card-text">
              <p class="small text-muted">
                Additional information
              </p>

              <#-- The card design supports up to 3 metadata fields -->
              <#if (result.listMetadata["eventPricingStandardMember"][0])!?has_content>
                <div class="truncate-text">
                  <div>Member Pricing</div>
                  <div class="fb-job__email truncate-text text-muted small">
                    ${(result.listMetadata["eventPricingStandardMember"][0])!?capitalize}
                  </div>
                </div>
              </#if>

              <#if (result.listMetadata["eventPricingStandardNonMember"][0])!?has_content>
                <div class="truncate-text">
                  <div>Non-member pricing</div>
                  <div class="fb-job__email truncate-text text-muted small">
                    ${(result.listMetadata["eventPricingStandardNonMember"][0])!?capitalize}
                  </div>
                </div>
              </#if>
            </div>
          </div>
        </#if>
        
        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >REGISTER</a>
          <#--  <a href="#" class="card-link fb-color-secondary">ACTION 2</a>    -->
          <span class="float-right enable-cart-on-result"></span>
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
  <script id="auto-completion-events" type="text/x-handlebar-template">
    <div class="fb-auto-complete--non-organic">
      {{#if extra.disp.metaData.eventImage}}
        <img class="rounded-circle fb-auto-complete__primary_visual" src="{{extra.disp.metaData.eventImage}}" alt="{{extra.disp.title}}" />
      {{else}}
        <img class="rounded-circle fb-auto-complete__primary_visual" alt="Thumbnail for {{extra.disp.title}}" src="https://source.unsplash.com/random/40x40?{{extra.disp.title}}"> 
      {{/if}}
      <div class="fb-auto-complete--non-organic__body">
        <h6 class="fb-auto-complete__body__primary-text">{{extra.disp.title}}</h6>
        <div class="fb-auto-complete__body__metadata text-muted">
          <span class="text-capitalize">{{extra.disp.metaData.eventLocation}}</span>
          <#--  {{#if extra.disp.metaData.peopleEmail}}
            <div class="fb-auto-complete__body__metadata text-muted">
              <small>
                <span class="far fa-fw fa-envelope text-muted" aria-hidden="true"></span> 
                {{extra.disp.metaData.peopleEmail}}
              </small>
            </div>
          {{/if}}  -->
        </div>
      </div>
    </div>    
  </script>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->

<#macro CartTemplate>
  <script id="cart-template-membership-association-events-web" type="text/x-handlebar-template">
    <div class="card fb-card--fixed mr-2 mb-2 ">
      {{#if metaData.eventImage}}            
        <img class="card-img-top" alt="Thumbnail for {{title}}" src="{{metaData.eventImage}}" /> 
      {{else}}
        <img class="card-img-top" alt="Thumbnail for {{title}}" src="https://source.unsplash.com/random/335x192?{{title}}"> 
      {{/if}}

      <div class="card-body fb-card__body">                
        <#-- Summary section containing the description and key details of the document -->
        <div class="fb-card__summary">
          <div class="card-title">          
            <h6>
              <a href="{{indexUrl}}">
                {{#if title}} 
                  {{title}}  
                {{/if}}
              </a>
            </h6>            
          </div>

          {{#if metaData.eventLocation}} 
            <div class="card-text truncate-text">
              <div class="mb-1"> {{metaData.eventLocation}} </div>
            </div>
          {{/if}}

          {{#if summary}}
            <p class="text-muted card-text">
              {{#truncate 255}}
                {{summary}}
              {{/truncate}}
            </p>
          {{/if}}

          {{#if metaData.jobPosted}} 
            <div class="card-text mb-3">
              <div class="small">
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

        <#-- Additional information such as metadata -->
        <div class="fb-card__additional-info">
          <hr class="mt-3 mb-3" />

          <div class="card-text mb-5">
            <p class="small text-muted">
              Additional information
            </p>

            <#-- The card design supports up to 3 metadata fields -->
            {{#if metaData.eventPricingStandardMember}}
              <div class="truncate-text">
                <div>Member Pricing</div>
                <div class="fb-job__email truncate-text text-muted small">
                  {{metaData.eventPricingStandardMember}}
                </div>
              </div>
            {{/if}}


            {{#if metaData.eventPricingStandardNonMember}}
              <div class="truncate-text">
                <div>Non-member pricing</div>
                <div class="fb-job__email truncate-text text-muted small">
                  {{metaData.eventPricingStandardNonMember}}
                </div>
              </div>
            {{/if}}
          </div>
        </div>
        
        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-card__actions__fb-link mt-4" data-toggle="modal" data-target="#signupModal" >REGISTER</a>
          <#--  <a href="#" class="card-link fb-color-secondary">ACTION 2</a>    -->
          <a class="card-link fb-cart__remove fb-card__actions__fb-link"></a>
        </div>
      </div>
    </div>
  </script>

  
</#macro>