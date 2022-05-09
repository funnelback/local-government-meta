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
    <!--results.people::GenericView -->
    <article class="listing-item listing-item--rates listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content>
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${(result.listMetadata["image"]?first)!}"> 
            </div>  
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.listMetadata["ratesPropertyID"]?first)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.listMetadata["ratesPropertyID"]?first)!?has_content>
                <div class="listing-item__header">
                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="listing-item__title-link">
                        <h3 class="listing-item__title">
                            Property ID:  
                            
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.listMetadata["ratesPropertyID"]?first)!}
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>
                </div>
            </#if>            
            
            <#-- Body -->
            <div class="listing-item__body">
                <#if result.collapsed??>
                    <div class="listing-item__summary">
                        <a class="listing-item__action" href="?${removeParam(QueryString, ["start_rank","duplicate_start_rank"])}&amp;s=%3F:${result.collapsed.signature}&amp;fmo=on&amp;collapsing=off">
                            SEE MORE 
                        </a>
                    </div>
                </#if>
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->                    
            <div class="listing-item__footer">
                <#if (result.listMetadata["ratesYear"]?first)!?has_content>                
                    <div class="listing-item__footer-block listing-item__footer-block">
                        ${(result.listMetadata["ratesYear"]?first)!}
                    </div>
                </#if>
                <#if (result.listMetadata["ratesPath"]?first)!?has_content>                
                    <div class="listing-item__footer-block listing-item__footer-block">
                        ${(result.listMetadata["ratesPath"]?first)!}
                    </div>
                </#if>
                <#if (result.listMetadata["ratesValue"]?first)!?has_content>                
                    <div class="listing-item__footer-block listing-item__footer-block">
                        ${(result.listMetadata["ratesValue"]?first)!}
                    </div>
                </#if>             
            </div>
        </div>
    </article>    
</#macro>

<#-- Output the cart template -->
<#macro ShortlistTemplate>
    <!-- results.rates::ShortlistTemplate -->    
    <#-- 
        Note: Cart templates as assigned to document types in profile.cfg/collection.cfg using 
        the following configuration:

        stencils.template.shortlist.<collection>=<type> 
        
        e.g. stencils.template.shortlist.higher-education-meta=programs

        For this to function correctly, the ID must be in the following format:
        id="shorlist-template-<type>".

        e.g. id="shorlist-template-programs"
    -->
    <script id="shortlist-template-rates" type="text/x-handlebars-template">
        <article class="listing-item listing-item--rates listing-item--background-grey10 listing-item--color-black" data-fb-result="{{indexUrl}}">   

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
                {{#if metaData.ratesPropertyID}} 
                    <div class="listing-item__header">
                        <a href="{{indexUrl}}" title="{{metaData.ratesPropertyID}}" class="listing-item__title-link">
                            <h3 class="listing-item__title">
                                {{#truncate 255}}
                                    {{metaData.ratesPropertyID}}  
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
                            {{#truncate 255}}
                                {{metaData.c}}  
                            {{/truncate}}
                        </div>
                    {{/if}} 

                    <p>
                        <span class="fb-cart__remove"></span>
                    </p>
                </div>          

                <#-- Footer -->                    
                <div class="listing-item__footer">
                    {{#if metaData.ratesYear}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            {{metaData.ratesYear}} years
                        </div>
                    {{/if}} 

                    {{#if metaData.ratesPath}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            {{metaData.ratesPath}} years
                        </div>
                    {{/if}} 

                    {{#if metaData.ratesValue}} 
                        <div class="listing-item__footer-block listing-item__footer-block">
                            {{metaData.ratesValue}} years
                        </div>
                    {{/if}} 
                </div>                                        
            </div>
        </article>    
    </script>
  
  </#macro>