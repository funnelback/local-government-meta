<#-- This file should be replaced by a copy of the Stencils file when
  deploying, to allow customization. Explicitly fail if the collection is not
  the showcase collection. To fix it, copy the file from
  $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
  question.collection.id == 'membership-association-meta' ||
  question.collection.id == 'local-government-meta'  
  >
  <#include "/share/stencils/libraries/base/history_cart.ftl">
<#else>
  <#-- Create a dummy version of a history_cart.ftl macro, as a way to display
    the error message -->
  <#macro LastVisitedLink result>
    <div class="alert alert-danger">
      <p><code>history_cart.ftl</code> is currently directly including the Stencils
      file. This is discouraged as Stencils changes will break the collection
      templates. Please make a copy of <code>history_cart.ftl</code> instead, from the
      Stencils sources (<code>$SEARCH_HOME/share/stencils/libraries/</code>).</p>

      <p>Subsequent template processing will fail until this is fixed.</p>
    </div>
  </#macro>
</#if>

<#-- Macro overrides specific for Funnelback for Local Government -->

<#--
  Display the click and search history
-->
<#macro SearchHistory>
  <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <section id="search-history" class="search-history mb-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <button tabindex="0" class="btn btn-link session-history-hide"><span class="fa fa-arrow-left"></span> Back to results</button>
            <h2 class="sr-only">Search history</h2>

            <div class="row">

              <#-- Click history -->
              <div class="col-md-6">
              <!-- ${session.clickHistory?size} -->
                <div class="card session-history-click-results">
                  <div class="card-header">
                    <h3>
                      <span class="fa fa-heart"></span> Recently clicked results
                      <button class="btn btn-danger btn-sm float-right session-history-clear-click" title="Clear click history"><span class="fa fa-times"></span> Clear</button>
                    </h3>
                  </div>
                  <div class="card-body">
                    <ul class="list-unstyled">
                      <#list session.clickHistory as h>
                        <li>
                          <a href="${h.indexUrl}">${h.title}</a> &middot; <span class="text-info">${prettyTime(h.clickDate)}</span>
                          <#if h.query??>
                            <span class="text-muted"> for &quot;${(h.query!"")?split("|")[0]?trim}&quot;</span>
                          </#if>
                        </li>
                      </#list>
                    </ul>
                  </div>
                </div>
              
                <div class="card session-history-click-empty">
                  <div class="card-header">
                    <h3><span class="fa fa-heart"></span> Recently clicked results</h3>
                  </div>
                  <div class="card-body">
                    <p class="text-muted">Your click history is empty.</p>
                  </div>
                </div>
              
              </div>

              <#-- Search history -->
              <div class="col-md-6">
              
                <div class="card session-history-search-results">
                  <div class="card-header">
                    <h3>
                      <span class="fa fa-search"></span> Recent searches
                      <button class="btn btn-danger btn-sm float-right session-history-clear-search" title="Clear search history"><span class="fa fa-times"></span> Clear</button>
                    </h3>
                  </div>
                  <div class="card-body">
                    <ul class="list-unstyled">
                      <#list session.searchHistory as h>
                        <li>
                          <a href="?${h.searchParams}">${h.originalQuery!} <small>(${h.totalMatching})</small></a> &middot; 
                          <span class="text-info">${prettyTime(h.searchDate)}</span>
                        </li>
                      </#list>
                    </ul>
                  </div>
                </div>
              
                <div class="card session-history-search-empty">
                  <div class="card-header">
                    <h3><span class="fa fa-search"></span> Recent searches</h3>
                  </div>
                  <div class="card-body">
                    <p class="text-muted">Your search history is empty.</p>
                  </div>
                </div>
              
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
  </#if>
</#macro>