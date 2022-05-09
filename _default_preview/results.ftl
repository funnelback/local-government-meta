<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
    Contains the default presentation logic for a 
    document which is not configured with its own 
    markup. 
-->

<#-- 
    Macro decides how each result should be presented. 

    @param result An individual result fron the data model
    @param view An uppercase string which represents how
        the result should be displayed. Defaults to LIST.
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
    <!-- results::GenericView -->
    <article class="listing-item listing-item--generic listing-item--background-grey10 listing-item--color-black" data-fb-result="${(result.indexUrl)!}">
        <#if (result.listMetadata["image"]?first)!?has_content>
            <div class="listing-item__image-wrapper">
                <img class="deferred listing-item__image" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/s/resources/${question.collection.id}/${question.profile}/img/pixel.gif" data-deferred-src="${result.listMetadata["image"]?first}"> 
            </div>  
        <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
            <div class="listing-item__image-wrapper">
                <img class="listing-item__image" alt="Thumbnail for ${result.title!}" src="https://picsum.photos/300/300?sig=${(result.title)!''?url}">
            </div>
        </#if>
        <div class="listing-item__content">
            <#-- Title -->
            <#if (result.title)!?has_content>
                <div class="listing-item__header">
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

                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="listing-item__title-link">
                        <h3 class="listing-item__title">
                            <@s.boldicize>
                                <@s.Truncate length=90>
                                    ${(result.title)!} 
                                </@s.Truncate>
                            </@s.boldicize>
                        </h3>
                    </a>

                    <#--  Example of subtitle with icon -->
                    <#--
                    <div class="listing-item__subtitle">
                        <svg class="svg-icon svg-icon--small">
                            <title>Location</title>
                            <use href="#map"></use>
                        </svg>
                        <a href="https://goo.gl/maps/3Ze7mNBpey6D6Q2k6" target="_blank" title="Opens in new window" class="listing-item__subtitle-link" rel="noreferrer">
                            Online
                        </a>
                    </div>
                    -->
                    <#-- Pretty version of the url of the document -->
                    <cite class="listing-item__subtitle listing-item__subtitle--highlight">
                        <@s.Truncate length=90>
                            ${(result.displayUrl)!}
                        </@s.Truncate>                
                    </cite>
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
                <#if (result.listMetadata["author"])!?has_content>
                    <ul aria-label="Result tags" class="listing-item__tags">
                        <#list result.listMetadata["author"] as author>
                            <li class="listing-item__tag">${author}</li>
                        </#list>
                    </ul>
                </#if>

                <#-- Call to Action (CTA) -->                        
                <#--  <a href="${result.clickTrackingUrl!}" class="listing-item__action">VIEW MORE</a>   -->
                <span class="enable-cart-on-result listing-item__action" 
                    aria-label="Add result to the shortlist">
                </span>  
            </div>          

            <#-- Display the time which this result has last been visited by the user -->
            <@sessions.LastVisitedLink result=result/> 

            <#-- Footer -->
            <#--              
                <div class="listing-item__footer">
                    <div class="listing-item__footer-block listing-item__footer-block">
                        <svg class="svg-icon svg-icon--small">
                            <title>Time</title>
                            <use href="#time">
                            </use>
                        </svg>
                        10:30 AM - 1:30 PM
                    </div>
                    <a href="mailto:it@department.edu" class="listing-item__footer-block listing-item__footer-block--highlight">
                        <svg class="svg-icon svg-icon--small">
                            <title>Contact email</title>
                            <use href="#email"></use>
                            </svg>
                            it@department.edu 
                    </a>
                    <a href="tel:650.725.4747" class="listing-item__footer-block listing-item__footer-block--highlight">
                        <svg class="svg-icon svg-icon--small">
                            <title>Contact phone</title>
                            <use href="#phone"></use>
                        </svg>
                        650.725.4747 
                    </a>
                </div>                                
            -->
        </div>
    </article>
</#macro>

<#-- Output the cart template -->
<#macro ShortlistTemplate>
    <!-- results::ShortlistTemplate -->    
    <#-- 
        Note: Cart templates as assigned to document types in profile.cfg/collection.cfg using 
        the following configuration:

        stencils.template.shortlist.<collection>=<type> 
        
        e.g. stencils.template.shortlist.higher-education-meta=programs

        For this to function correctly, the ID must be in the following format:
        id="shorlist-template-<type>".

        e.g. id="shorlist-template-programs"
    -->
    <script id="shortlist-template-default" type="text/x-handlebars-template">
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
                {{#if title}} 
                    <div class="listing-item__header">
                        <a href="{{indexUrl}}" title="{{title}}" class="listing-item__title-link">
                            <h3 class="listing-item__title">
                                {{#truncate 255}}
                                    {{title}}  
                                {{/truncate}}
                            </h3>
                        </a>

                        <#-- Pretty version of the url of the document -->
                        {{#if indexUrl}}  
                            <cite class="listing-item__subtitle listing-item__subtitle--highlight">
                                {{indexUrl}}
                            </cite>
                        {{/if}} 
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

                    <p>
                        <span class="fb-cart__remove"></span>
                    </p>
                </div>          
            </div>
        </article>    
    </script>  
</#macro>



