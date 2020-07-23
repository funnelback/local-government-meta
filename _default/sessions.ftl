<#ftl output_format="HTML" encoding="utf-8" />
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb/>

<!DOCTYPE html>
<html lang="en-us">
<head>

  <#-- 
    Sessions - Include the required CSS and javascript 
    Although strictly not required, the default templates
    used in the session plugin depends on the bootstrap 
    and jquery 3 and above.
  -->
  <link rel="stylesheet" href="${GlobalResourcesPrefix}thirdparty/bootstrap-3.3.7/css/bootstrap.min.css">

</head>
<body>
<div class="container">
  <#-- Display the search input -->
  <nav class="navbar navbar-default">
    <div class="collapse navbar-collapse">
      <form class="navbar-form navbar-left form-inline" action="${question.collection.configuration.value("ui.modern.search_link")}" method="GET">
        <input type="hidden" name="collection" value="${question.inputParameterMap["collection"]!}">
        <@s.IfDefCGI name="form"><input type="hidden" name="form" value="${question.inputParameterMap["form"]!}"></@s.IfDefCGI>
        <div class="form-group">
          <input required name="query" id="query" title="Search query" type="text" value="${question.inputParameterMap["query"]!}" accesskey="q" placeholder="Search <@s.cfg>service_name</@s.cfg>&hellip;" class="form-control query">
        </div>
        <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> Search</button>
      </form>
    </div>
  </nav>

  <#-- 
    Sessions - Cart and search & click history triggers
    Display the controls to used to hide and show cart and search & click history 
  -->
  <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <button type="button" class="btn btn-light flb-cart-count"></button>
    <button type="button" class="btn btn-light session-history-toggle">
      <i class="glyphicon glyphicon-time"></i>
    </button>
  </#if>

  <br />
  <br />    

  <#-- 
    Sessions - Recent searches
    Lists recent searches along with the associated 
    number of results returned. This provides a convenient way for 
    the user to rerun a previous queries.
  -->
  <#if question.collection.configuration.valueAsBoolean("ui.modern.session") && session.searchHistory?? && session.searchHistory?size gt 0>
    <#assign qsSignature = computeQueryStringSignature(QueryString) />
    <#if session.searchHistory?? && (session.searchHistory?size gt 1 || session.searchHistory[0].searchParamsSignature != qsSignature)>
      <div class="mt-3 breadcrumb session-history-breadcrumb">
        <button class="btn btn-link pull-right session-history-show"><small class="text-muted"><span class="glyphicon glyphicon-plus"></span> More&hellip;</small></button>
        <ol class="list-inline" >
          <li class="text-muted">Recent:</li>
          <#list session.searchHistory as h>
            <#if h.searchParamsSignature != qsSignature>
              <#outputformat "plainText">
              <#assign facetDescription><#compress>
              <#list h.searchParams?matches("f\\.([^=]+)=([^&]+)") as f>
                  ${urlDecode(f?groups[1])?split("|")[0]} = ${urlDecode(f?groups[2])}<#if f_has_next><br></#if>
              </#list>
              </#compress></#assign>
              </#outputformat>
              <li>
                <a <#if facetDescription != ""> data-toggle="tooltip" data-placement="bottom" title="${facetDescription}"</#if> title="${prettyTime(h.searchDate)}" href="${question.collection.configuration.value("ui.modern.search_link")}?${h.searchParams}">${h.originalQuery!} <small>(${h.totalMatching})</small></a>
                <#if facetDescription != ""><i class="glyphicon glyphicon-filter"></i></a></#if>
              </li>
            </#if>
          </#list>
        </ol>
      </div>
    </#if>
  </#if>

  <#-- 
    Sessions - Toggling content
    The session code supports the ability to toggle sections of the 
    page to give the cart, search & click history more prominance. 
    By default, the html elements with the id #search-results-content 
    and #search-cart will be toggled.
  -->
  <div id="search-results-content" class="row">
    
    <div>
      <h2 class="visible-print">Results</h2>

      <ol id="search-results" class="list-unstyled">
        <@s.Results>
          <#if s.result.class.simpleName == "TierBar">
          <#else>
            <#-- 
              Sessions - Enable the cart functionality to each result
              By default, Funnelback's cart functionality will be added
              to all H4 elements which have 'data-fb-result' data attribute
              define in one of it's parent element.   
            -->
            <li data-fb-result="${s.result.indexUrl}" class="result<#if !s.result.documentVisibleToUser>-undisclosed</#if>">
              <div>
              <h4>
                <a href="${s.result.clickTrackingUrl}" title="${s.result.liveUrl}">
                  <@s.boldicize><@s.Truncate length=70>${s.result.title}</@s.Truncate></@s.boldicize>
                </a>
                <#-- 
                  Sessions - Last visited link
                  The last visited link shows the most recent time a link
                  was opened/visited by the user. 
                -->
                <#if question.collection.configuration.valueAsBoolean("ui.modern.session") && session?? && session.getClickHistory(s.result.indexUrl)??>
                  <small class="text-warning session-history-link">
                    <span class="glyphicon glyphicon-time"></span> 
                    <a title="Click history" href="#" class="text-warning session-history-show">
                      Last visited ${prettyTime(session.getClickHistory(s.result.indexUrl).clickDate)}
                    </a>
                  </small>
                </#if>
              </h4>
              </div>
            </li>
          </#if>
        </@s.Results>
      </ol>

    </div>
  </div>

  <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <#-- 
      Sessions - Query and click history template 
      Determines how to display the query and click history.
    -->
    <div id="search-history">
      <div class="row">
        <div class="col-md-12">
          <a href="#" class="session-history-hide"><span class="glyphicon glyphicon-arrow-left"></span> Back to results</a>
          <h2><span class="glyphicon glyphicon-time"></span> History</h2>

          <div class="row">
            <div class="col-md-6">
              <h3>
                <span class="glyphicon glyphicon-heart"></span> Recently clicked results
                <button class="btn btn-danger btn-xs session-history-clear-click" title="Clear click history"><span class="glyphicon glyphicon-remove"></span> Clear</button>
              </h3>
              <#list session.clickHistory>
                <ul class="session-history-click-results">
                <#items as h>
                  <li><a href="${h.indexUrl}">${h.title}</a> &middot; <span class="text-warning">${prettyTime(h.clickDate)}</span><#if h.query??><span class="text-muted"> for &quot;${h.query!}&quot;</#if></span></li>
                </#items>
                </ul>
              </#list>
              <p class="session-history-click-empty text-muted">Your click history is empty.</p>
            </div>
            <div class="col-md-6">
              <h3>
                <span class="glyphicon glyphicon-search"></span> Recent searches
                <button class="btn btn-danger btn-xs session-history-clear-search" title="Clear search history"><span class="glyphicon glyphicon-remove"></span> Clear</button>
              </h3>
              <#list session.searchHistory>
                <ul class="session-history-search-results list-unstyled">
                <#items as h>
                  <li><a href="?${h.searchParams}">${h.originalQuery!} <small>(${h.totalMatching})</small></a> &middot; <span class="text-warning">${prettyTime(h.searchDate)}</span></li>
                </#items>
                </ul>
              </#list>
              <p class="session-history-search-empty text-muted">Your search history is empty.</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <#-- 
      Sessions - Cart placeholder 
      The session code will replace the following with the 
      required markup to display the cart.
    -->
    <div id="search-cart"></div>
  </#if>
</div>


<#-- 
  Sessions - Include the required CSS and javascript 
  Required for the cart and search & click history functionality.
-->
<script src="${GlobalResourcesPrefix}thirdparty/handlebars-4.1/handlebars.min.js"></script>


<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
  <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/es6-promise-4.2.5/es6-promise.auto.min.js"></script>
  <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-cart-0.1.min.js"></script>
  <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-history-0.1.min.js"></script>

  <script type="text/javascript">
    var flbSessionCart = new Funnelback.SessionCart({collection: '${question.collection.id}'});
    var flbSessionHistory = new Funnelback.SessionHistory({collection: '${question.collection.id}'});
  </script>
</#if>

</body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->