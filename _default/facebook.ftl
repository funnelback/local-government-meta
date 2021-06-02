<#ftl encoding="utf-8" output_format="HTML" />
<#import "history_cart.ftl" as history_cart />
<#import "base.ftl" as base />

<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
-->
<#macro Result result>
  <#switch result.listMetadata["facebookType"]?first!"">
    <#case "PAGE">
      <@PageResult result=result />
      <#break>
    <#case "POST">
      <@PostResult result=result />
      <#break>
    <#case "EVENT">
      <@EventResult result=result />
      <#break>
    <#default>
      <div class="alert alert-danger" role="alert">
        <#if !result.listMetadata["facebookType"]?first!?has_content>
          <strong>Facebook content type not available</strong>: Ensure the content possesses a
          <code>facebookType</code> metadata and that it is returned in the data model.
        <#else>
          <strong>Unsupported Facebook content type "${result.listMetadata["facebookType"]?first!}":</strong>
          You may need to create a result template for this content type
        </#if>
      </div>
    <#break>
  </#switch>
</#macro>

<#macro PostResult result=result>
  <li class="search-result search-result-facebook search-result-facebook-post mb-3">
    <div class="card">

      <div class="card-body">
        <div class="media">
          <a href="${result.customData["facebookProfileUrl"]!}">
            <img class="mr-3" src="${result.customData["facebookProfileImageUrl"]!}">
          </a>
          <div class="media-body">
            <i class="fab fa-facebook-square float-right text-muted" aria-hidden="true"></i>
            <h4>
              <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">${result.listMetadata["author"]?first!"Unknown author"}</a>
            </h4>
            <div class="card-subtitle text-muted">
              ${result.date?date?string("MMMM dd, yyyy")} via Facebook
              <@history_cart.LastVisitedLink result=result/>
            </div>
          </div>
        </div>

        <div class="card-text mt-3">
          <@s.boldicize>${response.customData.stencilsMethods.linkify(result.listMetadata["c"]?first!)?no_esc}</@s.boldicize>

          <#if result.listMetadata["facebookPostLink"]?first??>
            <hr>
            <#if result.listMetadata["image"]?first??>
              <img class="img-fluid float-right ml-3 deferred" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="<@base.MultiValuedMetadataDisplayFirst metadata=result.listMetadata["image"]?first! />">
            </#if>
            <h5><a href="${result.listMetadata["facebookPostLink"]?first!}">${result.listMetadata["facebookPostLinkName"]?first!}</a></h5>
            <p><@s.Truncate length=120>${result.listMetadata["facebookPostLinkDescription"]?first!}</@s.Truncate></p>
          </#if>
        </div>
      </div>
    </div>
  </li>
</#macro>

<#macro EventResult result=result>
  <li class="search-result search-result-event search-result-facebook search-result-facebook-event mb-3">
    <div class="card">
      <div class="card-body">

        <div class="card-title">
          <div class="media">
            <a href="${result.customData["facebookProfileUrl"]!}">
              <img class="mr-3" src="${result.customData["facebookProfileImageUrl"]!}">
            </a>
            <div class="media-body">
              <i class="fab fa-facebook-square float-right text-muted" aria-hidden="true"></i>
              <h4>
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                  <@s.boldicize><@s.Truncate length=70>${result.title!}</@s.Truncate></@s.boldicize>
                </a>

              </h4>
              <div class="card-subtitle text-muted">
                <a class="text-muted" href="${result.listMetadata["facebookProfileUrl"]?first!}">${result.listMetadata["author"]?first!"Unknown author"}</a> via Facebook
                <@history_cart.LastVisitedLink result=result/>
              </div>
            </div>
          </div>
        </div>

        <div class="card-text">

          <div class="row no-gutters">

            <div class="col-md-2">
              <div class="search-event-date text-center">
                <div class="search-event-date-month">
                  ${result.date?string("MMM")?upper_case}
                </div>
                <div class="search-event-date-day">
                  ${result.date?string("dd")}
                </div>
              </div>

              <#if result.listMetadata["d"]?first??>
                <div class="text-center">
                  <small>
                    ${result.listMetadata["d"]?first?datetime("yyyy-MM-dd HH:mm:ss.S z")?time?string.short}
                    <#if result.listMetadata["facebookEventEndDateTime"]?first??>
                      - ${result.listMetadata["facebookEventEndDateTime"]?first!?datetime("yyyy-MM-dd HH:mm:ss.S z")?time?string.short}
                    </#if>
                  </small>
                </div>
              </#if>
            </div>

            <div class="col-md-10">
              <#if result.listMetadata["image"]?first??>
                <img class="img-fluid float-right ml-3" alt="Thumbnail for ${result.title!}" src="<@base.MultiValuedMetadataDisplayFirst metadata=result.listMetadata["image"]?first! />">
              </#if>
              
              <p><@s.boldicize><@s.Truncate length=250>${response.customData.stencilsMethods.linkify(result.listMetadata["c"]?first!)?no_esc}</@s.Truncate></@s.boldicize></p>
            </div>

          </div>
        </div>
      </div>

      <#if result.listMetadata["facebookEventLocation"]?first??>
        <div class="card-footer">
          <span class="fas fa-fw fa-map-marker-alt text-muted"></span>
          <a class="text-muted" href="https://maps.google.com/?q=${result.listMetadata["facebookEventCoordinates"]?first!result.listMetadata["facebookEventLocation"]?first}" target="_blank">${result.listMetadata["facebookEventLocation"]?first!}</a>
        </div>
      </#if>
    </div>
  </li>
</#macro>

<#macro PageResult result=result>
  <li class="search-result search-result-facebook search-result-facebook-page mb-3">
    <div class="card">
      <div class="card-body">

        <div class="media">
          <a href="${result.customData["facebookPageImageUrl"]!}">
            <img class="mr-3" src="${result.customData["facebookPageImageUrl"]!}">
          </a>
          <div class="media-body">
            <i class="fab fa-facebook-square float-right text-muted" aria-hidden="true"></i>
            <h4>
              <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">${result.listMetadata["author"]?first!"Unknown author"}</a>
            </h4>
            <div class="card-subtitle text-muted">
              ${result.listMetadata["facebookPageCity"]?first!}, ${result.listMetadata["facebookPageCountry"]?first!}
              <@history_cart.LastVisitedLink result=result/>
            </div>
          </div>
        </div>

        <div class="card-text mt-3">
          <p><@s.boldicize>${response.customData.stencilsMethods.linkify(result.listMetadata["c"]?first!)?no_esc}</@s.boldicize></p>

          <#if result.listMetadata["facebookPageInfo"]?first??>
              <span class="fas fa-fw fa-info-circle text-muted"></span>
              ${response.customData.stencilsMethods.linkify(result.listMetadata["facebookPageInfo"]?first!)?no_esc}
          </#if>
        </div>
      </div>

      <div class="card-footer">
        <div class="row">
          <#if result.listMetadata["facebookPageWebsite"]?first??>
            <div class="col">
              <span class="fas fa-fw fa-globe text-muted"></span>
              <a class="text-muted" href="tel:${result.listMetadata["facebookPageWebsite"]?first!}">${result.listMetadata["facebookPageWebsite"]?first!}</a>
            </div>
          </#if>
          <#if result.listMetadata["facebookPagePhone"]?first??>
            <div class="col">
              <span class="fas fa-fw fa-phone text-muted"></span>
              <a class="text-muted" href="tel:${result.listMetadata["facebookPagePhone"]?first!}">${result.listMetadata["facebookPagePhone"]?first!}</a>
            </div>
          </#if>
        </div>
      </div>
    </div>
  </li>
</#macro>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
