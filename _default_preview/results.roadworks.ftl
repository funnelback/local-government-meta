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
    <!--results.roadworks::GenericView -->
    <article class="listing-item listing-item--roadworks listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content>
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
            </div>  
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.listMetadata['roadworksStreet']?first)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.listMetadata["roadworksStreet"]?first)!?has_content>
                <div class="listing-item__header">
                    <a href="${result.clickTrackingUrl!}" title="${(result.listMetadata["roadworksStreet"]?first)!}" class="listing-item__title-link">
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.listMetadata["roadworksStreet"]?first)!}
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
                    <#list result.listMetadata["roadworksWorkStatus"] as status>
                        <li class="listing-item__tag">${status}</li>
                    </#list>
                    <#list result.listMetadata["roadworksCategoryOfWorks"] as work>
                        <li class="listing-item__tag">${work}</li>
                    </#list>                        
                </ul>
                <#-- Call to Action (CTA) -->                        
                <a href="${result.clickTrackingUrl!}" class="listing-item__action">SHOW ON MAP</a>
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["roadworksStartDate"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon listing-item__icon">
                        <title>Time</title>
                        <use href="#time"></use>
                        </svg>
                        ${(result.listMetadata["roadworksStartDate"]?first)!}
                    </div>
                </#if>                  
                <#if (result.listMetadata["roadworksContactTelephoneNumber"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon listing-item__icon">
                        <title>Phone</title>
                        <use href="#phone"></use>
                        </svg>
                        ${(result.listMetadata["roadworksContactTelephoneNumber"]?first)!}
                    </div>
                </#if>                  
                <#if (result.listMetadata["roadworksLocality"]?first)!?has_content>
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon listing-item__icon">
                        <title>Locality</title>
                        <use href="#map"></use>
                        </svg>
                        ${(result.listMetadata["roadworksLocality"]?first)!}
                    </div>
                </#if>                  
            </div>
        </div>
    </article>    
</#macro>

<#-- Output the cart template -->
<#macro ShortlistTemplate>
    <!-- results.roadworks::ShortlistTemplate -->    
    <#-- 
        Note: Cart templates as assigned to document types in profile.cfg/collection.cfg using 
        the following configuration:

        stencils.template.shortlist.<collection>=<type> 
        
        e.g. stencils.template.shortlist.higher-education-meta=programs

        For this to function correctly, the ID must be in the following format:
        id="shorlist-template-<type>".

        e.g. id="shorlist-template-programs"
    -->
    <script id="shortlist-template-roadworks" type="text/x-handlebars-template">
        <article class="listing-item listing-item--roadworks listing-item--background-grey10 listing-item--color-black" data-fb-result="{{indexUrl}}">   

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
                {{#if metaData.roadworksStreet}} 
                    <div class="listing-item__header">
                        <a href="{{indexUrl}}" title="{{metaData.roadworksStreet}}" class="listing-item__title-link">
                            <h3 class="listing-item__title">
                                {{#truncate 255}}
                                    {{metaData.roadworksStreet}}  
                                {{/truncate}}
                            </h3>
                        </a>
                    </div>
                {{/if}}                 
                
                <#-- Body -->
                <div class="listing-item__body">
                    <#-- Summary -->
                    {{#if summary}} 
                        <div class="listing-item__summary">
                            {{#truncate 255}}
                                {{summary}}  
                            {{/truncate}}
                        </div>
                    {{/if}} 

                    <#-- Metadata should as tags/pills -->        
                    <ul aria-label="Result tags" class="listing-item__tags">                                    
                        {{#list metaData.roadworksWorkStatus joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}

                        {{#list metaData.roadworksCategoryOfWorks joinWith=", "}}
                            <li class="listing-item__tag">{{ this }}</li>
                        {{/list}}
                    </ul>

                    <p>
                        <span class="fb-cart__remove"></span>
                    </p>
                </div>          

                <#-- Footer -->                    
                <div class="listing-item__footer">
                    {{#if metaData.roadworksStartDate}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon listing-item__icon">
                                <title>Time</title>
                                <use href="#time">
                                </use>
                            </svg>
                            {{metaData.roadworksStartDate}} years
                        </div>
                    {{/if}} 

                    {{#if metaData.roadworksContactTelephoneNumber}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon listing-item__icon">
                                <title>Phone</title>
                                <use href="#phone"></use>
                            </svg>
                            {{metaData.roadworksContactTelephoneNumber}}
                        </div> 
                    {{/if}}

                    {{#if metaData.roadworksLocality}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            <svg class="svg-icon listing-item__icon">
                                <title>Locality</title>
                                <use href="#map"></use>
                            </svg>
                            {{metaData.roadworksLocality}}
                        </div> 
                    {{/if}}
                </div>                                        
            </div>
        </article>    
    </script>
  </#macro>

