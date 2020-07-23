<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />
<#import "history_cart.ftl" as history_cart />

<#-- 
  Macro decides how each result should be presented. 

  @param result An individual result fron the data model
  @param view An uppercase string which represents how
    the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result view="DETAILED_">
  <#switch view?upper_case>
    <#case "CARD">
      <@CardView result=result />
      <#break>
    <#case "DETAILED">
      <@DetailedView result=result />
      <#break>
    <#default>
      <@DetailedView result=result />
  </#switch>
</#macro>

<#--
  Stardard view of a result which is to be displayed in the 
  main section of the search engine result page (SERP)
  @param result An individual result fron the data model
-->


<#macro DetailedView result>
  <li data-fb-result="${result.indexUrl}" class="search-result search-result-course mb-3">
    <div class="card">
      <div class="card-body">

        <#-- Card title -->
        <div class="card-title">
          <div class="float-right">
            <@history_cart.LastVisitedLink result=result/>
          </div>
          
          <#if (result.title)!?has_content>
            <h5>
              <span class="fas fa-graduation-cap text-muted pull-right small mr-2" title="Event"></span>
              <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
                <@s.boldicize>
                  ${result.title!}
                </@s.boldicize>
              </a>

              <#if (result.metaData["courseSubject"])!?has_content && (result.metaData["courseNumber"])!?has_content>
                <small class="text-muted">(${result.metaData["courseSubject"]!}-${result.metaData["courseNumber"]!})</small>
              </#if>

            </h5>
          </#if>
        </div>

        <div class="card-subtitle text-muted">
          <#if result.metaData["courseDepartment"]??>
            ${result.metaData["courseDepartment"]}
          </#if>
        </div>

        <div class="card-text">
          <#if result.metaData["image"]??>
            <img class="img-fluid float-right ml-3" alt="Thumbnail for ${result.title}" src="<@base.MultiValuedMetadataDisplayFirst metadata=result.metaData["image"]! />">
          </#if>

          <#if result.metaData["courseDesc"]??>
            <@s.boldicize>${result.metaData["courseDesc"]?no_esc}</@s.boldicize>
          </#if>
        </div>
        
        <div class="card-text mt-3">
          <dl class="list-group list-group-flush">
            <div class="row">
              <div class="col-md-4">
                <dt>Credits</dt>
                <dd><@base.MultiValuedMetadataDisplay metadata=result.metaData["courseCredit"]!"-" /></dd>
              </div>

              <div class="col-md-4">
                <dt>Term</dt>
                <span><@base.MultiValuedMetadataDisplay metadata=result.metaData["courseTerm"]!"-" /></dd>
              </div>

              <div class="col-md-4">
                <dt>Delivery</dt>
                <dd><@base.MultiValuedMetadataDisplay metadata=result.metaData["courseDelivery"]!"-" /></dd>
              </div>
            </div>
          </dl>
        </div>
      </div>
    </div>
  </li>
</#macro>

<#macro ShortListTemplate>
  <div class="card search-result-course">

    <div class="card-header">
      <a href="javascript:;" class="btn btn-light border border-secondary float-right ng-cloak" data-ng-click="remove(item.indexUrl)">
        <span class="fas fa-times"></span>
        <span class="ng-cloak">Remove</span>
      </a>

      <h4>
        <a data-ng-href="{{item.indexUrl}}">
          {{item.title}}
        </a>
          <small data-ng-show="item.metaData.courseSubject && item.metaData.courseNumber" class="text-muted">({{item.metaData.courseSubject}}-{{item.metaData.courseNumber}})</small>
      </h4>
      <div class="card-subtitle text-muted">
        {{item.metaData.courseDepartment}}
      </div>
    </div>

    <div class="card-body">
      <div class="card-text">
        <img data-ng-show="item.metaData.I" class="img-fluid float-right ng-cloak" alt="Thumbnail for {{result.title}}" data-ng-src="{{item.metaData.I}}">
        {{item.metaData.courseDesc}}
      </div>

      <div class="row mt-3">
        <div class="col-md-4">
          <h5>Credits</h5>
          <span>{{item.metaData.courseCredit || '-'}}</span>
        </div>

        <div class="col-md-4">
          <h5>Term</h5>
          <span>{{item.metaData.courseTerm.replace('|', ', ').replace('|', ', ') || '-'}}</span>
        </div>

        <div class="col-md-4">
          <h5>Delivery</h5>
          <span>{{item.metaData.courseDelivery.replace('|', ', ') || '-'}}</span>
        </div>
      </div>

    </div>
  </div>
</#macro>

<#macro AutoCompleteTemplate>
  <script id="auto-completion-courses" type="text/x-handlebar-template">
    <div class="mt-2">
      <h6>{{extra.disp.title}} <small class="text-muted">{{extra.disp.metaData.courseSubject}}-{{extra.disp.metaData.courseNumber}}</small></h6>
      <div class="details">
        <small>{{extra.disp.metaData.courseTerm}}</small>
      </div>
    </div>
  </script>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
