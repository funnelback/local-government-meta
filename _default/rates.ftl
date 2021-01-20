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
    <!-- rates.GenericView -->
    <article class="search-results__item search-results__item--people" data-fb-result="${result.indexUrl}">
        <figure class="search-results__bg">
            <#if (result.listMetadata["image"]?first)!?has_content>
                <img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="https://jobs.ama.org${result.listMetadata["image"]?first}"> 
            <#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE"> 
                <img alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/160x160?${(result.listMetadata["ratesPropertyID"]?first)!''?url}"> 
            </#if>
        </figure>
        <div class="search-results__content">
            
            <#-- Title -->
            <h3 class="search-results__title">
                Property ID:                 
                
                <a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}" class="search-results__link">
                    
                    <@s.boldicize>
                        <@s.Truncate length=90>
                            ${(result.listMetadata["ratesPropertyID"]?first)!}
                        </@s.Truncate>
                    </@s.boldicize>
                </a>
            </h3>
            
            <#-- Subtitle -->
            <span class="search-results__sub-title">
                          
            </span>
            
            <#-- Summary -->
            <p class="search-results__desc">
                Year: ${(result.listMetadata["ratesYear"]?first)!}      
            </p>

            <@history_cart.LastVisitedLink result=result/>


            <#if result.collapsed??>
                <p>
                    <a class="search-result__collapsed btn--link" href="?${removeParam(QueryString, ["start_rank","duplicate_start_rank"])}&amp;s=%3F:${result.collapsed.signature}&amp;fmo=on&amp;collapsing=off">
                        See more 
                    </a>
                </p>
            </#if>

            <#-- Metadata located at the bottom -->
            <div class="search-results__bottom">
                <section class="contact js-contact">
                    <ul class="contact__list">                        
                        <#if (result.listMetadata["ratesYear"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["ratesYear"]?first)!}
                            </li>
                        </#if>
                        <#if (result.listMetadata["ratesPath"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["ratesPath"]?first)!}
                            </li>
                        </#if>   
                        <#if (result.listMetadata["ratesValue"]?first)!?has_content>
                            <li class="contact__item contact__item--icon contact__item--icon-location">
                                ${(result.listMetadata["ratesValue"]?first)!}
                            </li>
                        </#if>                                                                           
                    </ul>
                </section>
            </div>            
        </div>
    </article>
</#macro>


