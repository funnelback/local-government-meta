<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
  Allows the user to switch between prospective member and
  full fledge.
-->
<#macro UserTypeSwitcher>
  <div class="dropdown" >
    <a class="btn btn-light dropdown-toggle btn-sm" 
      href="#" 
      role="button" 
      id="dropdownMenuLinkUserTypeSwitcher" 
      data-toggle="dropdown" 
      aria-haspopup="true"
      aria-expanded="false"
      title="Change between member types">
      <i class="fas fa-user"></i>
    </a>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuLinkUserTypeSwitcher">
      
      <#-- Find out which user is active -->
      <#assign userTypes = (question.inputParameterMap['userTypes'])!"PROSPECTIVE">
      
      <#switch userTypes?upper_case>
        <#case "MEMBER">
          <a class="dropdown-item" href="?${removeParam(QueryString, ['userTypes']) + '&userTypes=prospective'}">
            Prospective Member
          </a>
          <a class="dropdown-item active" href="#">
            <i class="fas fa-check"></i> Full Member
          </a>
          <#break>
        <#case "PROSPECTIVE">
          <#-- No need to break. Prospective users are the default -->
        <#default>
          <a class="dropdown-item active" href="#">
            <i class="fas fa-check"></i> Prospective Member
          </a>
          <a class="dropdown-item" href="?${removeParam(QueryString, ['userTypes']) + '&userTypes=member'}">
            Full member
          </a>
          <#break>
      </#switch>      
    </div>
  </div>
</#macro>


<#macro SearchForm>
  <div class="search-form jumbotron jumbotron-fluid mb-0">
    <div class="container">
    <h2 class="text-center mb-4">Search Funnelback for Associations</h2>
      <@base.SearchForm>
        <div class="row">
          <div class="col-md-8 offset-md-2">
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text border-0 pl-0"><span class="fas fa-search"></span></span>
              </div>
              <input required name="query" id="query" title="Search query" type="search" autofocus value="${question.query!}" accesskey="q" class="form-control">

              <div class="input-group-text border-0 pr-0">
                <button type="submit" class="btn btn-secondary px-4">Search</button>
              </div>
            </div>

            <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
              <ul class="float-right list-inline">
                <li class="list-inline-item">
                  <button type="button" tabindex="0" class="btn btn-link">
                    <small>
                      <span class="flb-cart-count"></span>
                    </small>
                  </button>
                </li>
                <li class="list-inline-item">
                  <button type="button" tabindex="0" class="btn btn-link session-history-toggle">
                    <small>
                      <span class="fas fa-history"></span> History
                    </small>
                  </button>
                </li>
              </ul>
            </#if>

            <small class="float-left pt-1">Search powered by Funnelback</small>
          </div>
        </div>

        <#list ["userType", "displayMode"] as parameter>
          <@s.IfDefCGI name=parameter><input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}"></@s.IfDefCGI>
        </#list>

      </@base.SearchForm>
    </div>
  </div>
  <#-- Hiding recent queries until it as been factored into the design
    <@history_cart.RecentQueries />
  -->
</#macro>

<#macro Tabs>
  <nav class="tabs container-fluid">
    <div class="row">
      <div class="col-md-12">
        <h2 class="sr-only">Tabs</h2>
        <@tabs.Tabs />
      </div>
    </div>
  </nav>
</#macro>

<#macro Results>
  <section class="search-results p-3" id="search-results-content">
    <h2 class="sr-only">
      Search results
    </h2>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
        
          <#if (response.resultPacket.resultsSummary.totalMatching)! != 0>
            <@base.LimitDropdown />
            <@base.SortDropdown />
            <@base.DisplayMode />
          </#if>

          <@facets.SelectedFacetValues />

          <#if (response.resultPacket.spell)??>
            <div class="row search-spelling mb-3">
              <div class="col-md-12">
                <@base.Spelling />
              </div>
            </div>
          </#if>

          <#if (response.resultPacket.QSups)!?size gt 0>
            <div class="row search-blending">
              <div class="col-md-12">
                <@base.Blending />
              </div>
            </div>
          </#if>

          <div class="row search-counts text-muted mb-3">
            <div class="col-md-12">
              <@base.Counts />
            </div>
          </div>

          <@base.BestBets />
          <@base.CuratorExhibits position="center" />      

          <@base.NoResults />
          
          <div id="search-results">
            <@base.ResultList nestedRank=3>            
              <@fb.ExtraResults name="twitter">
                <li><h4 class="sr-only">Tweet results</h4></li>
                <li class="search-results-twitter">
                  <div class="row mb-3">
                    <#list (response.resultPacket.results)![] as result>
                      <#-- Limit to only 3 Twitter cards -->
                      <#if result?index lt 3>
                        <div class="col-md-4">
                          <@twitter.TwitterCard result=result />
                        </div>
                      </#if>
                    </#list>
                  </div>
                </li>
              </@fb.ExtraResults>
            </@base.ResultList>
          </div> 

          <@base.CuratorExhibits position="bottom" />

          <@base.Paging />

        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-12">
          <@base.ContextualNavigation />
        </div>
      </div>
    </div>
  </section>
</#macro>

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
  <li class="search-result search-result-web" data-fb-result="${result.indexUrl}">
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
                  <#-- Show an icon to represented the file type of the current document -->
                  <#switch result.fileType>
                    <#case "pdf">
                      <i class="far fa-file-pdf float-right text-muted" aria-hidden="true"></i>
                      <#break>
                    <#case "doc">
                    <#case "docx">
                    <#case "rtf">
                      <i class="far fa-file-word float-right text-muted" aria-hidden="true"></i>
                      <#break>
                    <#case "xls">
                    <#case "xlsx">
                      <i class="far fa-file-excel float-right text-muted" aria-hidden="true"></i>
                      <#break>
                    <#case "ppt">
                    <#case "pptx">
                      <i class="far fa-file-powerpoint float-right text-muted" aria-hidden="true"></i>
                      <#break>
                  </#switch>

                  <#--  <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>  -->
                  <a href="${result.clickTrackingUrl!}" title="${result.title!}">
                    <@s.boldicize>
                      <@s.Truncate length=90>
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

          <#-- Query biased summary -->
          <div class="card-text">
            <p class="text-muted">
              <@s.boldicize>
                ${result.summary!?no_esc}
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
              $70,000
            </span>

            <span class="badge badge-pill badge-light">
              full time
            </span>          

            <span class="badge badge-pill badge-light">
              something else
            </span>    

            <span class="badge badge-pill badge-light">
              another thing
            </span>    
          </div>
        </div>  -->

        <#-- Key call to actions (CTA) -->
        <#--  <div class="fb-card__actions"> 
          <a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >REGISTER NOW</a>
          <a href="#" class="card-link fb-color-secondary">ACTION 2</a>  
        </div>  -->

      </div>
    </div>
  </li>
</#macro>

<#macro SideNavigation>

  <#local tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${response.customData.stencilsTabsSelectedTab}")!>

  <#-- We always want to show the side bar for a consistent layout -->
  <nav class="fb-sidebar d-none d-sm-block">
    <#-- 
      We only want to show the facet titles and data if there
      they are available.
    -->
    <@facets.HasFacets facets=tabFacets>
      <div id="fb-session__side-navigation">        
        <div class="fb-sidebar__title fb-session__content-to-hide">              
          Refine you results
        </div>

        <div class="fb-sidebar__subtext text-muted fb-session__content-to-hide">
          <#--  Subtext  -->
        </div>

        <div class="fb_sidebar__content fb-session__content-to-hide">
          <@facets.Facets tabFacets />
        </div>
      </div>
    </@facets.HasFacets>
  </nav>
</#macro>

<#macro AutoComplete>
  <#if question.collection.configuration.hasValue("stencils.auto-completion.datasets")>
    jQuery('#query').qc({
        program: '<@s.cfg>auto-completion.program</@s.cfg>',
        alpha: '<@s.cfg>auto-completion.alpha</@s.cfg>',
        show: '<@s.cfg>auto-completion.show</@s.cfg>',
        sort: '<@s.cfg>auto-completion.sort</@s.cfg>',
        length: '<@s.cfg>auto-completion.length</@s.cfg>',
        datasets:{
          <#list question.collection.configuration.value("stencils.auto-completion.datasets")!?split(",") as dataset>
            ${dataset}: {
                name: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.name")!}',
                collection: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.collection")!}',
                profile: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.profile")!question.profile}',
                show: '${question.collection.configuration.value("stencils.auto-completion.datasets.${dataset}.show")!"10"}'
                <#if dataset != "organic">
                  , template: {
                    suggestion: jQuery('#auto-completion-${dataset}').text()
                  }
                </#if>
            }<#if dataset_has_next>,</#if>
          </#list>
        }
    });
  </#if>
</#macro>


<#macro SignupModal>
  <!-- Modal -->
  <div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">
            Why join us?
          </h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div>
            We’re building the essential community for marketers, and we need you.
            Joining the AMA not only connects you to other forward-thinking marketers but 
            also equips you with the knowledge to understand what’s coming next in the industry.
          </div>
          <br />
          <ul>
            <li>Access to all AMA content</li>
            <li>Unlimited AMA journal digital access</li>
            <li>Exclusive downloadable toolkits</li>
            <li>Best pricing for AMA events</li>
            <li>Discounts on Professional Certified Marketer® exams</li>
            <li>Members-only webcasts</li>
            <li>In-person networking opportunities through AMA local professional chapters</li>
          </ul>

          <hr />

          <form class="p-3">
            <h5>
              <i class="fas fa-user mr-3"></i>
              Ready? Create an account now
              </h5>
            <br /> 
            <div class="form-group row">
              <label for="inputEmail3" class="col-sm-1 col-form-label">
                <i class="fas fa-envelope text-muted"></i>
              </label>
              <div class="col-sm-11">
                <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
              </div>
            </div>
            <div class="form-group row">
              <label for="inputPassword3" class="col-sm-1 col-form-label">
                <i class="fas fa-key text-muted"></i>
              </label>
              <div class="col-sm-11">
                <input type="password" class="form-control" id="inputPassword3" placeholder="password">
              </div>
            </div>
            <button type="button" class="btn btn-dark btn-block" data-dismiss="modal">CREATE ACCOUNT</button>
          </form>          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
