<#ftl encoding="utf-8" output_format="HTML" />

<#macro TwitterCard result>
  <div class="card search-result search-result-twitter">
    <div class="card-body p-2">
      <div class="card-text">

        <div class="media">
          <a href="https://twitter.com/${result.metaData["author"]!}" title="@${result.metaData["author"]!} Twitter feed">
            <img class="ml-0 mr-1" src="${result.metaData["image"]!}" alt="@${result.metaData["author"]!} avatar">
          </a>
          <div class="media-body">

            <a class="text-muted" href="https://twitter.com/${result.metaData["author"]!}" title="@${result.metaData["author"]!} Twitter feed">@${result.metaData["author"]!}</a><br>

            <small class="text-muted">
              ${result.date?date?string("MMMM dd, yyyy")}
              via <i class="fab fa-twitter text-muted" aria-hidden="true"></i>
            </small>
          </div>
        </div>

        <div class="search-result-twitter-tweet mt-2"><@s.boldicize><@s.Truncate length=80>${result.metaData["c"]!?no_esc}</@s.Truncate></@s.boldicize></div>

        <div class="text-right text-muted">
          <a class="text-muted" href="${result.clickTrackingUrl}" title="Read full Tweet">read&hellip;</a>
        </div>
 
        </div>
      </div>
    </div>
</#macro>

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
