<#ftl encoding="utf-8" output_format="HTML" />
<#import "base.ftl" as base />

<#-- 
	Macro decides how each result should be presented. 

	@param result An individual result fron the data model
	@param view An uppercase string which represents how
		the result should be displayed. Defaults to LIST.
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
    <!-- cemetery.GenericView -->
    <article class="search-results__item search-results__item--people" data-fb-result="${result.indexUrl}">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"]?first)!?has_content>
                <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"]?first}"> 
            <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.listMetadata["cemeterySurname"]?first)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            <h3 class="search-results__title">
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}" class="search-results__link">
                    <@s.boldicize>
                        <@s.Truncate length=90>
                            ${(result.listMetadata["cemeterySurname"]?first)!}, ${(result.listMetadata["cemeteryFirstName"]?first)!}
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
                    Passed away
                        <#if (result.listMetadata["cemeteryDateDied"]?first)!?has_content>
                            on ${(result.listMetadata["cemeteryDateDied"]?first)!}
                        </#if> 
                    
                    <#if (result.listMetadata["cemeteryAge"]?first)!?has_content &&
                    (result.listMetadata["cemeteryAge"]?first)!?upper_case != "0">
                        at the age of ${(result.listMetadata["cemeteryAge"]?first)!} 
                        ${(result.listMetadata["cemeteryAgeUnit"]?first)!} 
                    </#if> 

                    <#if (result.listMetadata["cemeteryCemetery"]?first)!?has_content> 
                        <br />
                        Burried at ${(result.listMetadata["cemeteryCemetery"]?first)!} 
                        <#if (result.listMetadata["cemeteryDateBuried"]?first)!?has_content> 
                            on  ${(result.listMetadata["cemeteryDateBuried"]?first)!} 
                        </#if>
                    </#if>
                </@s.boldicize>
            </p>

            <p>
                <a href="#" class="btn--link">SHOW ON MAP</a> 
            </p>

            <@history_cart.LastVisitedLink result=result/>

            <div class="search-results__bottom">
                <section class="contact js-contact">
                    <ul class="contact__list">                        
                        <#if (result.listMetadata["cemeteryCemetery"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["cemeteryCemetery"]?first)!}
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
    <!-- cemetery.AutoCompleteTemplate -->
	<script id="auto-completion-cemetery" type="text/x-handlebars-template">
		<div class="fb-auto-complete--non-organic">
            <h6>
                {{extra.disp.metaData.cemeterySurname}}, {{extra.disp.metaData.cemeteryFirstName}}
            </h6>
			<div class="details">	
                Passed away on
                {{#if extra.disp.metaData.cemeteryDateDied}}
                    {{extra.disp.metaData.cemeteryDateDied}}
                {{/if}}        

                {{#if extra.disp.metaData.cemeteryAge}}
                    at the age of
                    {{extra.disp.metaData.cemeteryAge}}
                    {{extra.disp.metaData.cemeteryAgeUnit}}
                {{/if}}  

                {{#if extra.disp.metaData.cemeteryCemetery}}
                    <div>
                        Burried at {{extra.disp.metaData.cemeteryCemetery}}
                    </div>
                {{/if}}
            </div>              
		</div>    
	</script>
</#macro>

