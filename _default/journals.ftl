<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />

<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result=result view="DETAILED">
  <#if result.documentVisibleToUser!>
    <@FullAccessResult result=result view=view />
  <#else>
    <@RestrictedResult result=result view=view />
  </#if>
</#macro>

<#-- 
  Macro decides how result should be presented. Full access
  means the user has all the required permissions to access the
  particular document 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to DETAILED.
-->
<#macro FullAccessResult result view="LIST">
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
  Macro decides how restricted result should be presented.
  Restricted results are documents which the user does
  not have full access to.

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to LIST.
-->
<#macro RestrictedResult result view="LIST">
  <#switch view?upper_case>
    <#case "CARD">
      <@RestrictedCardView result=result />
      <#break>
    <#case "LIST">
      <@RestrictedListView result=result />
      <#break>
    <#default>
      <@RestrictedListView result=result />
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
  <li class="search-result search-result-journal">
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
              <#if (result.title)!?has_content>
                <h5>
                  <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                    <@s.boldicize>
                      <@s.Truncate length=70>
                        ${(result.title)!}
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
        <div class="fb-card__additional-info">
          <hr class="mt-3 mb-3" />

          <div class="card-text">
            <p class="small text-muted">
              Additional information
            </p>

            <span class="badge badge-pill badge-light">
              Members only content
            </span>
          </div>
        </div>

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="${result.clickTrackingUrl!}" class="card-link fb-color-secondary mt-4" title="${result.liveUrl!}">VIEW</a>
        </div>

      </div>
    </div>
  </li>
</#macro>

<#--
  A restricted list view of a result which is to be displayed in the 
  main section of the search engine result page (SERP)
  @param result An individual result fron the data model
-->
<#macro RestrictedListView result>
  <@RestrictedGenericView result=result cardClass="fb-card--list" />
</#macro>


<#--
  A restricted card view of a result which is to be displayed in the 
  main section of the search engine result page (SERP)
  @param result An individual result fron the data model
-->
<#macro RestrictedCardView result>
  <@RestrictedGenericView result=result cardClass="fb-card--fixed" />
</#macro>

<#--
  A restricted generic view used to drive both the the list and card view
  @param result An individual result fron the data model
-->
<#macro RestrictedGenericView result cardClass="fb-card--fixed">
  <li class="search-result search-result-journal" data-fb-result="${result.indexUrl}">
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
              <#if (result.title)!?has_content>
                <h5>
                  <a href="#" data-toggle="modal" data-target="#signupModal">
                    <@s.boldicize>
                      <@s.Truncate length=70>
                        ${(result.title)!}
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
          <div class="card-text">
            <p>
              <i class="fas fa-exclamation-circle"></i>
              This journal is only available to full members.
            </p>
            <p>
              Please register or sign in to get full access to all content available on 
              the American Marketing Association website. 
            </p>
          </div>

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

            <span class="badge badge-pill badge-warning">
              Members only content
            </span>
          </div>
        </div>

        <#-- Key call to actions (CTA) -->
        <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >REGISTER</a>
        </div>

      </div>
    </div>
  </li>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
