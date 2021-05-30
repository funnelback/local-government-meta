<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to DETAILED.
-->
<#macro Result result=result view="LIST">
    <#switch view?upper_case>
        <#case "CARD">
            <@CardView result=result />
            <#break>
        <#case "LIST">
            <#-- Determine if results should be hidden or not -->
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
    <@GenericView result=result />
</#macro>

<#--
    Card view of a result which is to be displayed in the 
    main section of the search engine result page (SERP)
    @param result An individual result fron the data model
-->
<#macro CardView result>
    <@GenericView result=result />
</#macro>

<#--
    A generic view used to drive both the the list and card view
    @param result An individual result fron the data model
-->
<#macro GenericView result >
    <!-- planning_applications.GenericView -->
    <article class="search-results__item search-results__item--people" data-fb-result="${result.indexUrl}">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"]?first)!?has_content>
                <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"]?first}"> 
            <#else>
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.listMetadata["planningApplicationName"]?first)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            <#-- Title -->
            <h3 class="search-results__title">
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}" class="search-results__link">
                    <@s.boldicize>
                        <@s.Truncate length=90>
                            ${(result.listMetadata["planningApplicationName"]?first)!}
                        </@s.Truncate>
                    </@s.boldicize>
                </a>
            </h3>
            
            <#-- Subtitle -->
            <span class="search-results__sub-title">
                ${(result.listMetadata["planningWardName"]?first)!}                
            </span>
            
            <#-- Summary -->
            <p class="search-results__desc">
                <@s.boldicize>
                    ${result.summary!?no_esc}
                </@s.boldicize>
            </p>

            <#-- Metadata can be shown as tags -->
            <section class="tags">
                <ul class="tags__list">
                    <li class="tags__item">
                        ${(result.listMetadata["planningSystemStatus"]?first)!}
                    </li>
                    <li class="tags__item">
                        ${(result.listMetadata["planningDecisionType"]?first)!}
                    </li>
                </ul>
            </section>

            <#-- Call to Action (CTA) -->
            <p>
                <a href="#" class="btn--link" aria-label="View the status of the planning application">VIEW STATUS</a> 
            </p>

            <#-- Display the time which this result has last been visited by the user -->
            <@history_cart.LastVisitedLink result=result/>

            <#-- Footer -->
            <div class="search-results__bottom">
                <section class="contact js-contact">
                    <ul class="contact__list">                        
                        <#if (result.listMetadata["planningRegisteredDate"]?first)!?has_content>
                           <li class="contact__item">
                                <span class="search-results__icon--red far fa-clock" title="Registered date"></span>
                                ${(result.listMetadata["planningRegisteredDate"]?first)!}
                            </li>
                        </#if>                        
                        
                        <#if (result.listMetadata["planningDevelopeAddress"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["planningDevelopeAddress"]?first)!}
                            </li>
                        </#if>                        
                    </ul>
                </section>
            </div>            
        </div>
    </article>
</#macro>


<#-- 
    Handlebars template used to display the current object
    in concierge.
--> 
<#macro AutoCompleteTemplate>
    <!-- planning_applications.AutoCompleteTemplate -->
    <script id="auto-completion-planning_applications" type="text/x-handlebars-template">
        <div class="fb-auto-complete--non-organic">
            <h6>
                {{extra.disp.listMetadata.planningApplicationName[0]}}
            </h6>
            <div class="details">
                {{#if extra.disp.listMetadata.planningWardName[0]}}
                    <div class="text-capitalize">{{extra.disp.listMetadata.planningWardName[0]}}</div>
                {{/if}}

                {{#if extra.disp.listMetadata.planningDevelopeAddress[0]}}
                    <div class="fb-auto-complete__body__metadata text-muted">
                        <span class="fas fa-map-marker-alt text-muted" aria-hidden="true"></span> 
                        {{extra.disp.listMetadata.planningDevelopeAddress[0]}}
                    </div>
                {{/if}}

                {{#if extra.disp.listMetadata.planningRegisteredDate[0]}}
                    <div class="fb-auto-complete__body__metadata text-muted">
                        <span class="fas fa-calendar-alt text-muted" aria-hidden="true"></span> 
                        Registered on {{extra.disp.listMetadata.planningRegisteredDate[0]}}
                    </div>
                {{/if}}
            </div>
        </div>
    </script>
</#macro>