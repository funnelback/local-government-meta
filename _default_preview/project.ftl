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

    <section class="module-search js-module-search content-wrapper module-search--bg" style="background-image: url('/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/bg-search.png');">
        <h2 class="sr-only">Search module</h2>
        <@base.SearchForm>
            <div class="module-search__group">
                <input type="hidden" name="collection" value="program-finder-meta">
                <label for="query" class="sr-only">Search</label>
                <span class="twitter-typeahead" style="position: relative; display: inline-block;">
                    <input name="query" id="query" type="search" class="module-search__query tt-input" autocomplete="off" placeholder="Start your search here…" value="science" spellcheck="false" dir="auto" style="position: relative; vertical-align: top;">
                    <pre aria-hidden="true" style="position: absolute; visibility: hidden;
                    white-space: pre; font-family: Gilroy, Arial, sans-serif; font-size: 25.0468px;
                    font-style: normal; font-variant: normal; font-weight: 300; word-spacing: 0px;
                    letter-spacing: 0px; text-indent: 0px; text-rendering: auto; text-transform: none;">science</pre>
                    <div class="tt-menu" style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;">
                        <div class="tt-dataset tt-dataset-organic">
                            <div class="tt-suggestion tt-selectable">
                                <strong class="tt-highlight">science</strong>
                            </div>
                            <div class="tt-suggestion tt-selectable">
                                <strong class="tt-highlight">science</strong>s</div>
                            <div class="tt-suggestion tt-selectable">
                                military <strong class="tt-highlight">science</strong> army rotc</div>
                            <div class="tt-suggestion tt-selectable">health
                                <strong class="tt-highlight">science</strong>
                            </div>
                            <div class="tt-suggestion tt-selectable">political
                                <strong class="tt-highlight">science</strong>
                            </div>
                            <div class="tt-suggestion tt-selectable">computer
                                <strong class="tt-highlight">science</strong>
                            </div>
                        </div>
                        <div class="tt-dataset tt-dataset-courses">
                            <h5 class="tt-category">Courses</h5>
                            <div class="tt-suggestion tt-selectable">
                                <h6>Success in Veterinary <strong>Science</strong>
                                    <small>VBMS-101</small>
                                </h6>
                                <div>
                                    Fall
                                </div>
                            </div>
                            <div class="tt-suggestion tt-selectable">
                                <h6>Success in Veterinary <strong>Science</strong>
                                    <small>VBMS-101</small>
                                </h6>
                                <div>
                                    Fall
                                </div>
                            </div>
                            <div class="tt-suggestion tt-selectable">
                                <h6>Success in Veterinary <strong>Science</strong>
                                    <small>VBMS-101</small>
                                </h6>
                                <div>
                                    Fall
                                </div>
                            </div>
                            <a href="#" class="module-search__more">Show more courses</a>
                        </div>
                        <div class="tt-dataset tt-dataset-people">
                            <h5 class="tt-category">People</h5>
                            <div class="module-search__list-item tt-suggestion tt-selectable">
                                <h6>Dan Giles</h6>
                                <span>Research Assistant,Professor</span>
                                <div class="details">
                                    <span class="details__item details__item--icon details__item--icon-university">
                                        Department Of Accounting,Department Of Political
                                        <strong class="tt-highlight">Science</strong>
                                    </span>
                                    <!--<span class="details__item details__item&#45;&#45;icon details__item&#45;&#45;icon-phone">-->
                                        <!--5836-->
                                    <!--</span>-->
                                    <!--<span class="details__item details__item&#45;&#45;icon details__item&#45;&#45;icon-envelope">-->
                                        <!--dan.giles@funnelback.edu-->
                                    <!--</span>-->
                                </div>
                            </div>
                            <div class="module-search__list-item tt-suggestion tt-selectable">
                                <h6>Dan Giles</h6>
                                <span>Research Assistant,Professor</span>
                                <div class="details">
                                    <span class="details__item details__item--icon details__item--icon-university">
                                        Department Of Accounting,Department Of Political
                                        <strong class="tt-highlight">Science</strong>
                                    </span>
                                    <!--<span class="details__item details__item&#45;&#45;icon details__item&#45;&#45;icon-phone">-->
                                        <!--5836-->
                                    <!--</span>-->
                                    <!--<span class="details__item details__item&#45;&#45;icon details__item&#45;&#45;icon-envelope">-->
                                        <!--dan.giles@funnelback.edu-->
                                    <!--</span>-->
                                </div>
                            </div>
                            <a href="#" class="module-search__more">Show more people</a>
                        </div>
                    </div>
                </span>
                <button type="submit" class="module-search__btn"><span class="sr-only">Search</span></button>
            </div>
        </@base.SearchForm>
    </section>


    <#-- Enable the cart and history button  -->
    <#--  
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
                                            <span class="fas fa-history"></span>
                                            History
                                    </small>
                            </button>
                    </li>
            </ul>
    </#if>  
    -->

    <#-- Hiding recent queries until it as been factored into the design
        <@history_cart.RecentQueries />
    -->
</#macro>

<#macro Tabs>
    <@tabs.Tabs />
</#macro>

<#macro Results>
    <div>
        <section class="search-results js-search-results">

            <div class="">
                <div class="search-results__tools">
                    <h2 class="search-results__tools-title sr-only">Search Funnelback University</h2>
                    <@base.Counts />
                    <div class="search-results__tools-right">
                        <a href="#" class="search-results__icon search-results__icon--box">
                            <span class="sr-only">Grid view</span>
                        </a>
                        <a href="#" class="search-results__icon search-results__icon--list active">
                            <span class="sr-only">List view</span>
                        </a>

                        <#--  
                        TODO: Add drop down for limit and sort
                        <#if (response.resultPacket.resultsSummary.totalMatching)! != 0>
                            <@base.LimitDropdown />
                            <@base.SortDropdown />
                            <@base.DisplayMode />
                        </#if>  
                        -->
                    </div>
                </div>


                <@curator.BestBets />                
                <@curator.Curator position="center" />      

                <#--  <@base.NoResults />  -->

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

                <@base.Paging />

                <section class="related-links">
                    <h2 class="related-links__title">Search related to
                        <strong>science</strong>
                    </h2>
                    <ul class="related-links__list">
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>definition</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>news</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>direct</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>games</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>definition</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>news</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>direct</strong>
                            </a>
                        </li>
                        <li class="related-links__item">
                            <a href="#" class="related-links__link">
                                Science
                                <strong>games</strong>
                            </a>
                        </li>
                    </ul>
                </section>

            </div>

        </section>


    </div>
</#macro>

<#macro Results2>
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
    <article class="search-results__item search-results__item--default">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"][0])!?has_content>
                <#--  <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${result.listMetadata["image"][0]}">   -->
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.title)!''?url}"> 
            <#else>
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.title)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            <#if (result.title)!?has_content>
                <h3 class="search-results__title">
                    <#-- Show an icon to represented the file type of the current document -->
                    <#switch result.fileType>
                        <#case "pdf">
                            <i class="far fa-file-pdf" aria-hidden="true"></i>
                            <#break>
                        <#case "doc">
                        <#case "docx">
                        <#case "rtf">
                            <i class="far fa-file-word" aria-hidden="true"></i>
                            <#break>
                        <#case "xls">
                        <#case "xlsx">
                            <i class="far fa-file-excel" aria-hidden="true"></i>
                            <#break>
                        <#case "ppt">
                        <#case "pptx">
                            <i class="far fa-file-powerpoint" aria-hidden="true"></i>
                            <#break>
                    </#switch>

                    <#--  <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>  -->
                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="search-results__link">
                        <@s.boldicize>
                            <@s.Truncate length=90>
                                ${(result.title)!} 
                            </@s.Truncate>
                        </@s.boldicize>
                    </a>
                </h3>
            </#if>
            
            <#-- Pretty version of the url of the document -->
            <cite>
                <@s.Truncate length=90>
                    ${(result.displayUrl)!}
                </@s.Truncate>
                
            </cite>

            
            <#-- Summary -->
            <p class="search-results__desc">
                <@s.boldicize>
                    ${result.summary!?no_esc}
                </@s.boldicize>
            </p>

            <section class="tags">
                <ul class="tags__list">
                    <li class="tags__item">
                        Lorem
                    </li>
                    <li class="tags__item">
                        Lorem ipsum
                    </li>
                    <li class="tags__item">
                        Lorem
                    </li>
                    <li class="tags__item">
                        Lorem ipsum
                    </li>
                    <li class="tags__item">
                        Lorem
                    </li>
                </ul>
            </section>

            <#-- Display the time which this result has last been visited by the user -->
            <@history_cart.LastVisitedLink result=result/>
        </div>
    </article>
</#macro>

<#macro Facets>
    <#local tabFacets = question.getCurrentProfileConfig().get("stencils.tabs.facets.${(response.customData.stencilsTabsSelectedTab)!}")!>

    <div>
        <section class="module-filter module-filter--dark js-module-filter">
            <@facets.HasFacets facets=tabFacets>
                <div class="module-filter__wrapper">
                    
                    <h2 class="module-filter__title">Filter by</h2>
                    <div class="module-filter__wrapper-mobile">
                        <@facets.Facets tabFacets />
                    </div>
                </div>
            </@facets.HasFacets>
        </section>
    </div>

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

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
