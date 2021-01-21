<#ftl encoding="utf-8" output_format="HTML" />

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
	<!-- services.GenericView -->
	<li class="search-result search-result-services">
		<div class="card ${cardClass!''}">
 
			<div class="card-body fb-card__body ">        

				<#-- Header section usually containing a title and small thumbnail -->
				<div class="fb-card__header mb-3">
					<div class="fb-card__header__image">
						<#if (result.listMetadata["image"]?first)!?has_content>
							<img class="deferred rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="/stencils/resources/base/v15.8/img/pixel.gif" data-deferred-src="${result.listMetadata["image"]?first}"> 
						<#elseif ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
							<img class="rounded-circle fb-image-thumbnail" alt="Thumbnail for ${result.title!}" src="https://source.unsplash.com/random/40x40?${(result.title)!''?url}"> 
						</#if>
					</div>

					<div class="fb-card__header__title">
						<div class="card-title">          
							<#if (result.title)!?has_content>
								<h5>
									<a href="${result.clickTrackingUrl!}" title="${result.liveUrl!}">
										<@s.boldicize>
											<@s.Truncate length=90>
												${(result.title)!}
											</@s.Truncate>
										</@s.boldicize>
									</a>
								</h5>            
							</#if>
						</div>
					</div>
				</div>
				
				<#-- Summary section containing the description and key details of the document -->
				<div class="fb-card__summary">
					<#if (result.listMetadata["serviceLocality"]?first)!?has_content> 
						<div class="card-text">
							<div class="mb-1"> ${(result.listMetadata["serviceLocality"]?first)!} </div>
							<p class="text-muted small truncate-text">
								${(result.listMetadata["serviceAddress"]?first)!}
							</p>
						</div>
					</#if>

					<div class="card-text">
						<p class="text-muted">
							<@s.boldicize>
								${result.summary!?no_esc}
							</@s.boldicize>
						</p>
					</div>

					<div class="card-text">
						<@history_cart.LastVisitedLink result=result/>
					</div>
				</div>   

				<#-- Additional information such as metadata -->
				<#--  <div class="fb-card__additional-info">
					<hr class="mt-3 mb-3" />

					<div class="card-text">
						<p class="small text-muted">
							Additional information
						</p>
						<span class="badge badge-pill badge-light">
							$70,000
						</span>
						<span class="badge badge-pill badge-light">
							full time
						</span>          

						<span class="badge badge-pill badge-light">
							something else
						</span>    

						<span class="badge badge-pill badge-light">
							another thing
						</span>    
					</div>
				</div>  -->

				<#-- Key call to actions (CTA) -->
				<div class="fb-card__actions"> 
					<a href="#" class="card-link fb-color-secondary mt-4" data-toggle="modal" data-target="#signupModal" >VIEW</a>
				</div>

			</div>
		</div>
	</li>
</#macro>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
