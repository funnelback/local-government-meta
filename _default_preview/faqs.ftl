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
    <!-- faqs.GenericView -->
    <article class="search-results__item search-results__item--default" data-fb-result="${(result.indexUrl)!}">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"]?first)!?has_content>
                <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="//${httpRequest.getHeader('host')}/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${result.listMetadata["image"]?first}">   -->
            <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE"> 
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/collection/73776582/160x160"> 
            </#if>   
        </figure>
        <div class="search-results__content">
            <#if (result.title)!?has_content>
                <h4 class="search-results__title">
                    <#--  <span class="fas fa-briefcase text-muted pull-right small mr-2" title="Job"></span>  -->
                    <a href="${result.clickTrackingUrl!}" title="${result.title!}" class="search-results__link">
                        <@s.boldicize>
                            <@s.Truncate length=90>
                                ${(result.title)!} 
                            </@s.Truncate>
                        </@s.boldicize>
                    </a>
                </h4>
            </#if>
            
            <#-- Pretty version of the url of the document -->
            <#--  <cite>
                <@s.Truncate length=90>
                    ${(result.displayUrl)!}
                </@s.Truncate>                
            </cite>  -->

            
            <#-- Summary -->
            <#if (result.listMetadata["faqAnswer"]?first)!?has_content>
                <p class="search-results__desc">
                    <@s.boldicize>
                        <@s.Truncate length=250>
                            ${(result.listMetadata["faqAnswer"]?first)!}                        
                        </@s.Truncate>
                    </@s.boldicize>
                </p>
            </#if> 

            <#-- Metadata can be shown as tags -->
            
            <section class="tags">                
                <ul class="tags__list">                                    
                    <#list result.listMetadata["faqType"]![] as type>                    
                        <li class="tags__item">
                            ${type!}
                        </li>
                    </#list>
                </ul>
            </section>  
          

            <#-- Display the time which this result has last been visited by the user -->
            <@history_cart.LastVisitedLink result=result/>            
        </div>
    </article>
</#macro>

<#-- 
	Handlebars template used to display the current object
	in concierge.
--> 
<#macro AutoCompleteTemplate>
    <!-- faqs.AutoCompleteTemplate -->
	<script id="auto-completion-faqs" type="text/x-handlebars-template">
		<div class="fb-auto-complete--non-organic">
            <h6>
                {{extra.disp.metaData.t}}
            </h6>
			<div class="details">	
                {{#if extra.disp.metaData.faqAnswer}}                    
                    {{#truncate 70}}{{extra.disp.metaData.faqAnswer}}{{/truncate}}                    
                {{/if}}
            </div>              
		</div>    
	</script>
</#macro>
