<#ftl encoding="utf-8" output_format="HTML" />
<#import "history_cart.ftl" as history_cart />

<#macro Result result>
  <li class="search-result search-result-video mb-3">
    <div class="card">

      <div class="row no-gutters">
        <div class="col-md-3 my-auto">
          <a href="${result.clickTrackingUrl}" title="${result.liveUrl}" target="_blank">
            <img class="card-img img-fluid" alt="Thumbnail for ${result.title}" src="${result.metaData["image"]!}">
            
            <div class="card-img-overlay text-center">
              <span class="far fa-play-circle fa-4x"></span>
              <#if result.metaData["videoDurationPretty"]??>
                <span class="badge badge-default">${result.metaData["videoDurationPretty"]!}</span>
              <#elseif result.metaData["videoDuration"]??>
                <span class="badge badge-default">${result.metaData["videoDuration"]!?number}s</span>
              </#if>
            </div>
          </a>
          
        </div>


        <div class="col-md-9">
          <div class="card-body">
            <div class="card-title">
              <h4>
                <a href="${result.clickTrackingUrl}" title="${result.liveUrl}">
                  <@s.boldicize><@s.Truncate length=70>${result.title}</@s.Truncate></@s.boldicize>
                </a>
              </h4>
              <div class="card-subtitle text-muted">
                <small>${result.date?date?string.short!} - Uploaded by ${result.metaData["videoAuthor"]!"Unknown"}</small>
                <@history_cart.LastVisitedLink result=result/>
              </div>
            </div>

            <div class="card-text">
              <@s.boldicize><@s.Truncate length=70>${result.metaData["c"]!?no_esc}</@s.Truncate></@s.boldicize>
            </div>
          </div>
        </div>
      </div>
    </div>
  </li>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
