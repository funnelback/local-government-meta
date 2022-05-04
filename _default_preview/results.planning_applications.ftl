<#ftl encoding="utf-8" output_format="HTML" />

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
<#macro GenericView result>
    <!--results.planning_applications::GenericView -->
    <article class="listing-item listing-item--people listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content>
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
            </div>  
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.listMetadata["planningApplicationName"]?first)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.listMetadata["planningApplicationName"]?first)!?has_content>
                <div class="listing-item__header">
                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="listing-item__title-link">
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.listMetadata["planningApplicationName"]?first)!}
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>
                </div>
            </#if>
                        
            <#-- Body -->
            <div class="listing-item__body">
                <#-- Summary -->
                <div class="listing-item__summary">
                    <@s.boldicize>
                        ${result.summary!?no_esc}
                    </@s.boldicize>
                </div>

                <#-- Metadata should as tags/pills -->        
                <ul aria-label="Result tags" class="listing-item__tags">
                    <#list result.listMetadata["planningSystemStatus"]![] as planningSystemStatus>
                        <li class="listing-item__tag">${planningSystemStatus}</li>
                    </#list>
                    <#list result.listMetadata["planningDecisionType"]![] as planningDecisionType>
                        <li class="listing-item__tag">${planningDecisionType}</li>
                    </#list>                        
                </ul>

                <#-- Call to Action (CTA) -->                        
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW STATUS</a>
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["planningRegisteredDate"]?first)!?has_content>                
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Registered date</title>
                            <use href="#calendar"></use>
                        </svg>
                        ${(result.listMetadata["planningRegisteredDate"]?first)!}
                    </div>
                </#if>
                <#if (result.listMetadata["planningDevelopementAddress"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Time</title>
                            <use href="#map"></use>
                        </svg>
                        ${(result.listMetadata["planningDevelopementAddress"]?first)!}
                    </div>
                </#if>                  
            </div>
        </div>
    </article>    
</#macro>

<#-- Output the cart template -->
<#macro ShortlistTemplate>
    <!-- results.planning_applications::ShortlistTemplate -->    
    <#-- 
        Note: Cart templates as assigned to document types in profile.cfg/collection.cfg using 
        the following configuration:

        stencils.template.shortlist.<collection>=<type> 
        
        e.g. stencils.template.shortlist.higher-education-meta=programs

        For this to function correctly, the ID must be in the following format:
        id="shorlist-template-<type>".

        e.g. id="shorlist-template-programs"
    -->
    <script id="shortlist-template-planning_applications" type="text/x-handlebars-template">
        <article class="listing-item listing-item--program listing-item--background-grey10 listing-item--color-black" data-fb-result="{{indexUrl}}">   

            {{#if metaData.image}} 
                <div class="listing-item__image-wrapper">
                    <img class="listing-item__image" alt="Thumbnail for {{title}}" src="{{metaData.image}}"> 
                </div> 
                <#-- Show a placeholder image for showcase -->     
                <#if ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
                    {{else}}
                    <div class="listing-item__image-wrapper">
                        <img class="listing-item__image" alt="Thumbnail for {{title}}" src="https://picsum.photos/300/300?sig={{title}}">
                    </div>
                </#if>
            {{/if}} 
            <div class="listing-item__content">
                <#-- Title -->
                {{#if metaData.planningApplicationName}} 
                    <div class="listing-item__header">
                        <a href="{{indexUrl}}" title="{{metaData.planningApplicationName}}" class="listing-item__title-link">
                            <h3 class="listing-item__title">
                                {{#truncate 255}}
                                    {{metaData.planningApplicationName}}         
                                {{/truncate}}
                            </h3>
                        </a>
                    </div>
                {{/if}} 
                
                
                <#-- Body -->
                <div class="listing-item__body">
                    <#-- Summary -->
                    {{#if metaData.c}} 
                        <div class="listing-item__summary">
                            {{#truncate 555}}
                                {{metaData.c}}  
                            {{/truncate}}
                        </div>
                    {{/if}} 

                    <#-- Metadata should as tags/pills -->        
                    <ul aria-label="Result tags" class="listing-item__tags">                                    
                        {{#list metaData.planningSystemStatus joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}

                        {{#list metaData.planningDecisionType joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}
                    </ul>

                    <p>
                        <span class="fb-cart__remove"></span>
                    </p>

                    <span class="enable-cart-on-result listing-item__action" 
                            aria-label="Add result to the shortlist">
                    </span> 
                </div>          

                <#-- Footer -->                    
                <div class="listing-item__footer">
                    {{#if metaData.planningRegisteredDate}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon svg-icon--small">
                                <title>Registered date</title>
                                <use href="#calendar"></use>
                            </svg>                            
                            {{metaData.planningRegisteredDate}} years
                        </div>
                    {{/if}} 

                    {{#if metaData.planningDevelopementAddress}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon svg-icon--small">
                                <title>Time</title>
                                <use href="#map"></use>
                            </svg>
                            {{metaData.planningDevelopementAddress}}
                        </div> 
                    {{/if}} 
                </div>                                        
            </div>
        </article>    
    </script>
  
  </#macro>