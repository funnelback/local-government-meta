<#ftl encoding="utf-8" output_format="HTML" />

<#-- Not to be used in production -->

<#-- This file should be replaced by a copy of the Stencils file when
    deploying, to allow customization. Explicitly fail if the collection is not
    the showcase collection. To fix it, copy the file from
    $SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
    question.collection.id == 'membership-association-meta' ||
    question.collection.id == 'local-government-meta'
    >
    <#include "/share/stencils/libraries/base/base.ftl">
<#else>
    <#-- Create a dummy version of a base.ftl macro, as a way to display
        the error message -->
    <#macro SearchForm>
        <div class="alert alert-danger">
            <p><code>base.ftl</code> is currently directly including the Stencils
            file. This is discouraged as Stencils changes will break the collection
            templates. Please make a copy of <code>base.ftl</code> instead, from the
            Stencils sources (<code>$SEARCH_HOME/share/stencils/libraries/</code>).</p>

            <p>Subsequent template processing will fail until this is fixed.</p>
        </div>
    </#macro>
</#if>

<#-- 
    Macros specific to Vertical Product instance 
    These can override those found in Stencils. 
    i.e. Given /share/stencils/libraries/foo.ftl defines @SomeMacro,
    and is included is this template, it can be overriden by 
    defining <macro SomeMacro>. 
--> 

<#---
    Generates a search form for the current collection, passing through the
    relevant parameters like collection, profile, form, scope, ...

    @param preserveTab Boolean indicating if searching via the form should preserve the currently selected tab or not
    @param class Optional <code>class</code> attribute to use on the &lt;form&gt; tag
-->
<#macro SearchForm preserveTab=true class="">
    <form action="${question.getCurrentProfileConfig().get("ui.modern.search_link")}" method="GET"<#if class?has_content> class="${class}"</#if>>
        <input type="hidden" name="collection" value="${question.collection.id}">

        <#list ["enc", "form", "scope", "lang", "profile", "userType", "displayMode"] as parameter>
            <@s.IfDefCGI name=parameter><input type="hidden" name="${parameter}" value="${question.inputParameterMap[parameter]!}"></@s.IfDefCGI>
        </#list>

        <#if preserveTab>
            <#list question.selectedCategoryValues?keys as facetKey>
                <#if facetKey?starts_with("f.Tabs|")>
                    <#list question.selectedCategoryValues[facetKey] as value>
                        <input type="hidden" name="${facetKey}" value="${value}">
                    </#list>
                </#if>
            </#list>
        </#if>

        <#nested>

    </form>
</#macro>


<#-- Obtain the result mode from the CGI paramters; Valid values are LIST and CARD -->
<#function getDisplayMode question>
    <#-- Default the display mode to "list" -->
    <#assign displayMode = ""> 

    <#-- Get the mode that is currently configured -->
    <#if (question.inputParameterMap["displayMode"])!?has_content>
        <#-- Get the value from the user's selection -->
        <#assign displayMode = question.inputParameterMap["displayMode"]!?upper_case>
    <#elseif (question.getCurrentProfileConfig().get("stencils.results.display_mode"))!?has_content>
        <#-- Get the value from profile config -->
        <#assign displayMode = question.getCurrentProfileConfig().get("stencils.results.display_mode")!?upper_case>
    <#else>
        <#-- Default -->
        <#assign displayMode = "LIST"> 
    </#if>

    <#return displayMode>
</#function>

<#macro DisplayMode>
    <label for="fb-display-control" class="sr-only">Display: </label>
    <div id="fb-display-control" class="btn-group float-right mr-1 fb-search-controls" aria-label="Display controls">
        <button type="button" class="btn btn-light <#if getDisplayMode(question)! == 'LIST'>active</#if>">
            <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=list'
                title="Display results as a list"
            >
                <i class="fas fa-list"></i>
            </a>
        </button>
        <button type="button" class="btn btn-light <#if getDisplayMode(question)! == 'CARD'>active</#if>">
            <a href='${question.getCurrentProfileConfig().get("ui.modern.search_link")}?${removeParam(QueryString, "displayMode")}&displayMode=card'
                title="Display results as cards"
            >
                <i class="fas fa-th"></i>
            </a>
        </button>    
    </div>

</#macro>

<#--
  Generate an HTML drop-down for sorting results

  @param options Map of sort options, where keys are the `sort` paratmeter (e.g. `date`) and values the label (e.g. `Date (Newest first)`)
-->
<#macro SortDropdown options={
  "": "Relevance",
  "date": "Date (Newest first)",
  "adate": "Date (Oldest first)",
  "title": "Title (A-Z)",
  "dtitle": "Title (Z-A)",
  "prox": "Distance",
  "url": "URL (A-Z)",
  "durl": "URL (Z-A)",
  "shuffle": "Shuffle"} >
  <div class="dropdown float-right">
    <button class="btn btn-light btn-sm dropdown-toggle" id="search-sort" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      <span class="text-muted">Sort:</span> ${options[question.inputParameterMap["sort"]!]}
    </button>
    <div class="dropdown-menu" aria-labelledby="search-sort">
      <#list options as key, value>
        <a class="dropdown-item" title="Sort by ${value}" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "sort")}&sort=${key}">${value}</a>
      </#list>
    </div>
  </div>
</#macro>

<#--
  Generate an HTML drop-down to control the number of results

  @param limits Array of number of results to provide (defaults to 10, 20, 50)
-->
<#macro LimitDropdown limits=[10, 20, 50]>
  <div class="dropdown float-right ml-1">
    <button class="btn btn-light btn-sm dropdown-toggle" id="search-limit" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      <span class="text-muted">Limit:</span> ${question.inputParameterMap["num_ranks"]!"10"}
    </button>
    <div class="dropdown-menu" aria-labelledby="search-limit">
      <#list limits as limit>
        <a class="dropdown-item" title="Limit to ${limit} results" href="${question.collection.configuration.value("ui.modern.search_link")}?${removeParam(QueryString, "num_ranks")}&num_ranks=${limit}">${limit} results</a>
      </#list>
    </div>
  </div>
</#macro>

<#-- 
    Determines if the results are to be displayed normally
    or grouped together by some criteria
-->
<#macro ResultList nestedRank=-1>
    <#assign displayMode = getDisplayMode(question)>

    <#if (response.customData["stencilsGroupingResults"].mode)!?has_content>
        <@GroupedResults view=displayMode/>
    <#else>
        <@StandardResults view=displayMode nestedRank=-1>
            <#nested>    
        </@StandardResults>
    </#if>
</#macro>

<#--
    Iterate over results and choose the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param nestedRank Before which result to insert the nested content of the macro.
        This is used to insert content (usually an extra search) between results.
-->
<#macro StandardResults view="LIST" nestedRank=-1>
    <article class="search-results__list search-results__list--list-view">
        <#list (response.resultPacket.resultsWithTierBars)![] as result>
            <#if result.class.simpleName == "TierBar">
                <div class="row tier-bar">      
                    <div class="col-md-12">
                        <@TierBar result=result />
                    </div>
                </div>
            <#else>
                <#if nestedRank gte 0 && result.rank == nestedRank>
                    <#nested>
                </#if>
                
                <#-- Display the result based on the configured template -->
                <@Result result=result view=view/>
                <#--  <article class="search-results__item search-results__item--video">
                    <a href="#">
                        <figure class="search-results__bg">
                            <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/img2.jpg" alt="">
                        </figure>
                    </a>
                    <div class="search-results__content">
                        <h3 class="search-results__title">
                            <a href="#" class="search-results__link">
                                Lorem ipsum dolor (Ph.D.), consetetur sadipscing elitr
                            </a>
                        </h3>
                        <p class="search-results__desc">
                            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod Lorem ipsum dolor sit
                                        amet, consetetur sadipscing elitr, sed diam nonumy eirmod Lorem ipsum dolor sit amet, consetetur
                                        sadipscing elitr, sed diam nonumy eirmod
                        </p>
                    </div>
                </article>

                <article class="search-results__item search-results__item--default">
                    <figure class="search-results__bg">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/img-1.jpg" alt="">
                    </figure>
                    <div class="search-results__content">
                        <h3 class="search-results__title">
                            Lorem ipsum dolor (Ph.D.)
                        </h3>
                        <p class="search-results__desc">
                            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                        </p>
                        <div class="search-results__bottom">
                            <a href="#" class="btn--link">Read more</a>
                        </div>
                    </div>
                </article>

                <article class="search-results__item search-results__item--event">
                    <figure class="search-results__bg">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/img-1.jpg" alt="">
                    </figure>
                    <time class="search-results__time" datetime="08-27">
                        <span class="search-results__month">Sep</span>
                        <span class="search-results__day">27</span>
                    </time>
                    <div class="search-results__content">
                        <h3 class="search-results__title">
                            <a href="#" class="search-results__link">
                                Lorem ipsum dolor (Ph.D.)
                            </a>
                        </h3>
                        <span class="search-results__sub-title">Office of the Dean, School of Medicine</span>
                        <p class="search-results__desc">
                            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
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

                        <div class="search-results__bottom">
                            <section class="contact js-contact">
                                <div class="contact__item contact__item--event-time contact__item--icon contact__item--icon-clock">
                                    <time datetime="2020-08-27T16:30:00">4:30 PM</time>
                                    -
                                    <time datetime="2020-08-27T18:30:00">6:30 PM</time>
                                </div>

                                <ul class="contact__list">
                                    <li class="contact__item contact__item--icon contact__item--icon-envelope">
                                        <a href="mailto:cbmuller@stanford.edu" class="contact__link">cbmuller@stanford.edu</a>
                                    </li>
                                    <li class="contact__item contact__item--icon contact__item--icon-phone">
                                        <a href="tel:4593" class="contact__link">4593</a>
                                    </li>
                                    <li class="contact__item contact__item--icon contact__item--icon-location">
                                        <span>Canberra Tuggeranong</span>
                                    </li>
                                </ul>
                            </section>

                        </div>
                    </div>
                </article>

                <article class="search-results__item search-results__item--people">
                    <figure class="search-results__bg">
                        <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/people1.png" alt="">
                    </figure>
                    <div class="search-results__content">
                        <h3 class="search-results__title">
                            <a href="#" class="search-results__link">
                                Lorem ipsum dolor (Ph.D.)
                            </a>
                        </h3>
                        <span class="search-results__sub-title">Office of the Dean, School of Medicine</span>
                        <p class="search-results__desc">
                            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                        </p>
                        <div class="search-results__bottom">
                            <section class="contact js-contact">
                                <ul class="contact__list">
                                    <li class="contact__item contact__item--icon contact__item--icon-envelope">
                                        <a href="mailto:cbmuller@stanford.edu" class="contact__link">cbmuller@stanford.edu</a>
                                    </li>
                                    <li class="contact__item contact__item--icon contact__item--icon-phone">
                                        <a href="tel:4593" class="contact__link">4593</a>
                                    </li>
                                    <li class="contact__item contact__item--icon contact__item--icon-location">
                                        <span>Canberra Tuggeranong</span>
                                    </li>
                                </ul>
                            </section>

                        </div>
                    </div>
                </article>

                <article class="search-results__item search-results__item--default">
                    <figure class="search-results__bg"></figure>
                    <div class="search-results__content">
                        <h3 class="search-results__title">
                            <a href="#" class="search-results__link">
                                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
                            </a>
                        </h3>
                        <p class="search-results__desc">
                            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod.
                                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
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

                    </div>
                </article>

                <article class="search-results__item search-results__item--col search-results__item--twitter">
                    <article>
                        <figure class="search-results__bg">
                            <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/people1.png" alt="">
                        </figure>
                        <div class="search-results__header">
                            <h3 class="search-results__title">
                                <a href="#" class="search-results__link">
                                    @Sydney_Uni
                                </a>
                            </h3>
                            <time class="icon-after icon-after--twitter" datetime="">March 14, 2018 via</time>
                        </div>
                        <div class="search-results__content">
                            <p class="search-results__desc">
                                RT @Sydney_Science: Happy #PiDay2018! This year we’re celebrating with…
                            </p>
                        </div>
                    </article>
                    <article>
                        <figure class="search-results__bg">
                            <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/people1.png" alt="14-03-2018">
                        </figure>
                        <div class="search-results__header">
                            <h3 class="search-results__title">
                                <a href="#" class="search-results__link">
                                    @Sydney_Uni
                                </a>
                            </h3>
                            <time class="icon-after icon-after--twitter" datetime="14-03-2018">March 14, 2018 via</time>
                        </div>
                        <div class="search-results__content">
                            <p class="search-results__desc">
                                RT @Sydney_Science: Happy #PiDay2018! This year we’re celebrating with…
                            </p>
                        </div>
                    </article>
                    <article>
                        <figure class="search-results__bg">
                            <img src="/s/resources/${question.collection.id}/${question.profile}/css/mysource_files/people1.png" alt="">
                        </figure>
                        <div class="search-results__header">
                            <h3 class="search-results__title">
                                <a href="#" class="search-results__link">
                                    @Sydney_Uni
                                </a>
                            </h3>
                            <time class="icon-after icon-after--twitter" datetime="14-03-2018">March 14, 2018 via</time>
                        </div>
                        <div class="search-results__content">
                            <p class="search-results__desc">
                                RT @Sydney_Science: Happy #PiDay2018! This year we’re celebrating with…
                            </p>
                        </div>
                    </article>
                </article>  -->
            </#if>
        </#list>
    </article>

</#macro>

<#--
    Displays a search result using the the right template depending
    on the results type and what is configured in collection.cfg

    Defaults to <code>&lt;@project.Result /&gt;

    @param result The search result to output
-->
<#macro Result result question=question view="LIST">
    <#-- Get result template depending on collection name -->
    <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${result.collection}")!"" />

    <#-- If not defined, attempt to get it depending on the gscopes the result belong to -->
    <#if !resultDisplayLibrary?has_content>
        <#list (result.gscopesSet)![] as gscope>
            <#assign resultDisplayLibrary = question.getCurrentProfileConfig().get("stencils.template.result.${gscope}")!"" />
            <#if resultDisplayLibrary?has_content>
                <#break>
            </#if>
        </#list>
    </#if>

    <#if .main[resultDisplayLibrary]??>
        <@.main[resultDisplayLibrary].Result result=result view=view />
    <#elseif .main["project"]??>
        <#-- Default Result macro in current namespace -->
        <@.main["project"].Result result=result view=view />
    <#else>
        <div class="alert alert-danger" role="alert">
            <strong>Result template not found</strong>: Template <code>&lt;@<#if resultDisplayLibrary?has_content>${resultDisplayLibrary}<#else>(default namespace)</#if>.Result /&gt;</code>
            not found for result from collection <em>${result.collection}</em>.
        </div>
    </#if>
</#macro>

<#macro GroupedResults view="LIST">
    <#-- Loop through each grouped result tier -->
    <#if (response.resultPacket.results)!?has_content>
        <#list (response.customData["stencilsGroupingResults"].groups)![] as group>
            <div class="mb-3">
                <#-- Create facet link to be used in the title and "see more" -->
                <#assign searchLink = question.getCurrentProfileConfig().get("ui.modern.search_link")!>
                <#assign facetLink = (group.url)!"">

                <span>
                    <h3>
                        <a class="text-muted" href="${searchLink + facetLink}">           
                            ${group.label}
                        </a>
                    </h3>
                </span>
        
                <ol class="list-unstyled fb-result-set fb-display-mode--${view?lower_case}">
                    <#list response.resultPacket.results as result>                        
                        <#-- Display the result based on the configured template -->
                        <#switch ((response.customData["stencilsGroupingResults"].mode)!"")?upper_case>
                            <#case "METADATA">
                                <#if (result.metaData[group.field])!?has_content>
                                    <@Result result=result view=view />
                                </#if>
                                <#break> 
                            <#case "COLLECTION">
                                <#if result.collection == (group.field)!"">
                                    <@Result result=result view=view />
                                </#if>
                                <#break>
                            <#default>                
                                <#break>
                        </#switch>         
                    </#list>
                </ol>

                <#-- See more link -->
                <span class="clearfix">        
                    <a href="${searchLink + facetLink}"> 
                        <i class="fas fa-arrow-right mr-1"></i>
                        See more ${group.label} 
                    </a>
                </span>
            </div>
        </#list>    
    </#if>
</#macro>

<#--
    Message to display when there are no results
-->
<#macro NoResults>
    <#if (response.resultPacket.resultsSummary.totalMatching)! == 0>
        <div class="mb-5">
            <h3><i class="fas fa-exclamation-circle"></i> No results</h3>
            <p>Your search for <strong><@s.QueryClean /></strong> did not return any results. Please ensure that you:</p>
            <ul >
                <li>are not using any advanced search operators like + - | " etc.</li>
                <li>expect this document to exist within the <em><@s.cfg>service_name</@s.cfg></em> collection <@s.IfDefCGI name="scope"> and within <em><@s.Truncate length=80>${question.inputParameterMap["scope"]!}</@s.Truncate></em></@s.IfDefCGI></li>
                <li>have permission to see any documents that may match your query</li>
            </ul>
        </div>

        <div class="mb-5">
            <h3>Trending searches</h3>
            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                <div class="col-auto d-none d-lg-block">
                    <img src="https://www.ama.org/wp-content/themes/ama/assets/images/placeholder-image-small.png" alt="..." width="350">
                </div>
                <div class="col p-4 d-flex flex-column position-static">
                    <h4 class="">What other members are looking for</h3>
                    <ul>
                        <li>
                            <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=membership+benefits">
                                <span>Membership benefits</span>
                            </a>
                        </li>
                        <li>
                            <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=coronavirus+and+the+impacts+on+marketing">
                                <span>Coronavirus and the impacts on marketing</span>
                            </a>
                        </li>
                        <li>
                            <a href="${question.collection.configuration.value('ui.modern.search_link')}?${removeParam(QueryString,['query','start_rank'])}&query=upcoming+events">
                                <span>Upcoming events</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>      
        </div>

        <div>
            <h3 class="mt-3 mb-3">You could also try</h3>
            <div class="card-deck">
                <div class="card">
                    <img src="https://www.ama.org/wp-content/uploads/2020/02/undraw_social-girl.jpg?resize=486%2C365" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Contact Us</h5>
                        <div class="card-text">
                            Give us a call at 1-800-AMA-1150. Our customer support team is available Monday through Friday, 8:30 a.m. - 5 p.m. CDT.
                        </div>
                    </div>
                </div>
                <div class="card">
                    <img src="https://www.ama.org/wp-content/uploads/2020/02/TS20-Demand-Generation-Website-Card-New.png?resize=486%2C365" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Professional Chapter Leaders</h5>
                        <div class="card-text">
                            <ul>
                                <li><a href="https://myama.force.com/s/article/Codes-of-Conduct"><span>Codes of Conduct</span></a></li>
                                <li><a href="https://myama.force.com/s/article/Group-Discount-Program-for-AMA-Membership"><span>Group Discount Program for AMA Membership</span></a></li>
                                <li><a href="https://myama.force.com/s/article/AMA-Community-Help"><span>AMA Community Help</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <img src="https://www.ama.org/wp-content/uploads/2020/02/WEB_virtue.jpg?resize=486%2C365" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Certification and Training</h5>
                        <div class="card-text">
                            <ul>
                                <li><a href="https://myama.force.com/s/article/How-to-Maintain-Your-Professional-Certified-Marketer-PCM-Certification" >How to Maintain Your Professional Certified Marketer (PCM) Certification and Record CEUs</span></a></li>
                                <li><a href="https://myama.force.com/s/article/How-to-access-PCM-certification-exams" >How to access PCM certification exams.</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </#if>

</#macro>


<#--
  Display query blending notice
-->
<#macro Blending>
  <#if (response.resultPacket.QSups)!?size &gt; 0>
    <blockquote class="blockquote">
      <span class="fas fa-info-circle"></span>
      Your query has been expanded to <strong><#list response.resultPacket.QSups as qsup> ${qsup.query}<#if qsup_has_next>, </#if></#list></strong>.
      &nbsp;Search for <a href="?${QueryString}&amp;qsup=off" title="Turn off query expansion"><em>${question.originalQuery}</em></a> instead.
    </blockquote>
  </#if>
</#macro>

<#--
  Display spelling suggestion notice
-->
<#macro Spelling>
    <#if (response.resultPacket.spell)??>
      <div class="search-spelling">
        <span class="fas fa-question-circle"></span>
        Did you mean <em><a href="${question.collection.configuration.value("ui.modern.search_link")}?${response.resultPacket.spell.url}" title="Spelling suggestion">${response.resultPacket.spell.text}</a></em>?
      </div>
    </#if>
</#macro>

<#--
  Message to display when there are no results
-->
<#macro NoResults>
  <#if (response.resultPacket.resultsSummary.totalMatching)! == 0>
    <h3><span class="glyphicon glyphicon-warning-sign"></span> No results</h3>
    <p>Your search for <strong><@s.QueryClean /></strong> did not return any results. Please ensure that you:</p>
    <ul>
      <li>are not using any advanced search operators like + - | " etc.</li>
      <li>expect this document to exist within the <em><@s.cfg>service_name</@s.cfg></em> collection <@s.IfDefCGI name="scope"> and within <em><@s.Truncate length=80>${question.inputParameterMap["scope"]!}</@s.Truncate></em></@s.IfDefCGI></li>
      <li>have permission to see any documents that may match your query</li>
    </ul>
  </#if>
</#macro>

<#--
  Display the contextual navigation panel
-->
<#macro ContextualNavigation>
  <#if ((response.resultPacket.contextualNavigation.categories)![])?size gt 0>
    <div class="card search-contextual-navigation">
      <div class="card-body">
        <div class="card-title">
          <h3>Related searches for <strong><@s.QueryClean /></strong></h3>
        </div>

        <div class="card-text">
          <div class="row">
            <#list (response.resultPacket.contextualNavigation.categories)![] as category>
              <div class="col">
                <h4 class="text-muted">By ${category.name}</h4>
                <ul class="list-unstyled ml-3">
                  <#list category.clusters as cluster>
                    <li class="list-item-unstyled"><a href="${cluster.href}">${cluster.label?replace("...", " <strong>${response.resultPacket.contextualNavigation.searchTerm} </strong> ")?no_esc}</a></li>
                  </#list>
                </ul>
              </div>
            </#list>
          </div>
        </div>
      </div>
    </div>
  </#if>
</#macro>


<#--
    Display result counts
-->
<#macro Counts>
    <span class="search-results__total">                                                                    
        <#if response.resultPacket.resultsSummary.totalMatching == 0>
            <span class="search-counts-total-matching">0</span> search results for <strong class="highlight"><@s.QueryClean /></strong>
        </#if>
        <#if response.resultPacket.resultsSummary.totalMatching != 0>
            <span class="search-counts-page-start">${response.resultPacket.resultsSummary.currStart}</span> -
            <span class="search-counts-page-end">${response.resultPacket.resultsSummary.currEnd}</span> of
            <span class="search-counts-total-matching">${response.resultPacket.resultsSummary.totalMatching?string.number}</span>
            <#if question.inputParameterMap["s"]?? && question.inputParameterMap["s"]?contains("?:")>
                <em>collapsed</em> 
            </#if>search results for <strong class="highlight"><@s.QueryClean></@s.QueryClean></strong> 
            <#list response.resultPacket.QSups as qsup>
                or <strong class="highlight">${qsup.query}</strong>
                <#if qsup_has_next>, </#if>
            </#list>
        </#if>

        <#if (response.resultPacket.resultsSummary.partiallyMatching!0) != 0>
            where <span class="search-counts-fully-matching">${response.resultPacket.resultsSummary.fullyMatching?string.number}</span>
            match all words and <span class="search-counts-partially-matching">${response.resultPacket.resultsSummary.partiallyMatching?string.number}</span>
            match some words.
        </#if>
        <#if (response.resultPacket.resultsSummary.collapsed!0) != 0>
            <span class="search-counts-collapsed">${response.resultPacket.resultsSummary.collapsed}</span>
            very similar results included.
        </#if>
    </span>
</#macro>

<#--
  Display paging controls
-->
<#macro Paging>
    <section class="pagination">
        <nav class="pagination__nav" aria-label="Pagination Navigation">
            <#-- Previous page -->
            <#if response.customData.stencilsPaging.previousUrl??>
                <div class="pagination__item pagination__item-navigation pagination__item-previous">
                    <a class="pagination__link" rel="prev" href="href="${response.customData.stencilsPaging.previousUrl}"">
                        <span class="pagination__label">Prev</span>
                    </a>
                </div>
            </#if>

            <#-- Sibling pages -->
            <#if response.customData.stencilsPaging.pages?size gt 1>
                <ul class="pagination__pages-list">
                    <#list response.customData.stencilsPaging.pages as page>
                        <#if page.selected>
                            <li class="pagination__item pagination__item--active">

                                <span class="pagination__current" aria-label="Current Page, Page ${page.number}">
                                    <span class="pagination__label">${page.number}</span>
                                </span>                            
                            </li>
                        <#else>                    
                            <li class="pagination__item">
                                <a class="pagination__link" href="${page.url}" aria-label="Goto Page 1">
                                    <span class="pagination__label">${page.number}</span>
                                </a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>

            <#-- Next page -->
            <#if response.customData.stencilsPaging.nextUrl??>            
                <div class="pagination__item pagination__item-navigation pagination__item-next">
                    <a class="pagination__link" href="${response.customData.stencilsPaging.nextUrl}" rel="next">
                        <span class="pagination__label">Next</span>
                    </a>
                </div>
            </#if> 
        </nav>
    </section>
</#macro>