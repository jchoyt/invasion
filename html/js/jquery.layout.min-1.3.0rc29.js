;(function($){var $b=$.browser;$.layout={browser:{mozilla:!!$b.mozilla,webkit:!!$b.webkit||!!$b.safari,msie:!!$b.msie,isIE6:!!$b.msie&&$b.version==6,boxModel:false},scrollbarWidth:function(){return window.scrollbarWidth||$.layout.getScrollbarSize('width');},scrollbarHeight:function(){return window.scrollbarHeight||$.layout.getScrollbarSize('height');},getScrollbarSize:function(dim){var $c=$('<div style="position: absolute; top: -10000px; left: -10000px; width: 100px; height: 100px; overflow: scroll;"></div>').appendTo("body");var d={width:$c.width()-$c[0].clientWidth,height:$c.height()-$c[0].clientHeight};$c.remove();window.scrollbarWidth=d.width;window.scrollbarHeight=d.height;return dim.match(/^(width|height)$/i)?d[dim]:d;},showInvisibly:function($E,force){if(!$E)return{};if(!$E.jquery)$E=$($E);var CSS={display:$E.css('display'),visibility:$E.css('visibility')};if(force||CSS.display=="none"){$E.css({display:"block",visibility:"hidden"});return CSS;}
else return{};},getElemDims:function($E){var
d={},x=d.css={},i={},b,p,off=$E.offset();d.offsetLeft=off.left;d.offsetTop=off.top;$.each("Left,Right,Top,Bottom".split(","),function(idx,e){b=x["border"+e]=$.layout.borderWidth($E,e);p=x["padding"+e]=$.layout.cssNum($E,"padding"+e);i[e]=b+p;d["inset"+e]=p;});d.offsetWidth=$E.innerWidth();d.offsetHeight=$E.innerHeight();d.outerWidth=$E.outerWidth();d.outerHeight=$E.outerHeight();d.innerWidth=d.outerWidth-i.Left-i.Right;d.innerHeight=d.outerHeight-i.Top-i.Bottom;x.width=$E.width();x.height=$E.height();return d;},getElemCSS:function($E,list){var
CSS={},style=$E[0].style,props=list.split(","),sides="Top,Bottom,Left,Right".split(","),attrs="Color,Style,Width".split(","),p,s,a,i,j,k;for(i=0;i<props.length;i++){p=props[i];if(p.match(/(border|padding|margin)$/))
for(j=0;j<4;j++){s=sides[j];if(p=="border")
for(k=0;k<3;k++){a=attrs[k];CSS[p+s+a]=style[p+s+a];}
else
CSS[p+s]=style[p+s];}
else
CSS[p]=style[p];};return CSS},cssWidth:function($E,outerWidth){var
b=$.layout.borderWidth,n=$.layout.cssNum;if(outerWidth<=0)return 0;if(!$.layout.browser.boxModel)return outerWidth;var W=outerWidth
-b($E,"Left")
-b($E,"Right")
-n($E,"paddingLeft")
-n($E,"paddingRight");return Math.max(0,W);},cssHeight:function($E,outerHeight){var
b=$.layout.borderWidth,n=$.layout.cssNum;if(outerHeight<=0)return 0;if(!$.layout.browser.boxModel)return outerHeight;var H=outerHeight
-b($E,"Top")
-b($E,"Bottom")
-n($E,"paddingTop")
-n($E,"paddingBottom");return Math.max(0,H);},cssNum:function($E,prop){if(!$E.jquery)$E=$($E);var CSS=$.layout.showInvisibly($E);var val=parseInt($.curCSS($E[0],prop,true),10)||0;$E.css(CSS);return val;},borderWidth:function(el,side){if(el.jquery)el=el[0];var b="border"+side.substr(0,1).toUpperCase()+side.substr(1);return $.curCSS(el,b+"Style",true)=="none"?0:(parseInt($.curCSS(el,b+"Width",true),10)||0);},isMouseOverElem:function(evt,el){var
$E=$(el||this),d=$E.offset(),T=d.top,L=d.left,R=L+$E.outerWidth(),B=T+$E.outerHeight(),x=evt.pageX,y=evt.pageY;return($.layout.browser.msie&&x<0&&y<0)||((x>=L&&x<=R)&&(y>=T&&y<=B));}};$.fn.layout=function(opts){var lang={Pane:"Pane",Open:"Open",Close:"Close",Resize:"Resize",Slide:"Slide Open",Pin:"Pin",Unpin:"Un-Pin",selector:"selector",msgNoRoom:"Not enough room to show this pane.",errContainerMissing:"UI Layout Initialization Error\n\nThe specified layout-container does not exist.",errCenterPaneMissing:"UI Layout Initialization Error\n\nThe center-pane element does not exist.\n\nThe center-pane is a required element.",errContainerHeight:"UI Layout Initialization Warning\n\nThe layout-container \"CONTAINER\" has no height.\n\nTherefore the layout is 0-height and hence 'invisible'!",errButton:"Error Adding Button \n\nInvalid "};var options={name:"",containerClass:"ui-layout-container",scrollToBookmarkOnLoad:true,resizeWithWindow:true,resizeWithWindowDelay:200,resizeWithWindowMaxDelay:0,onresizeall_start:null,onresizeall_end:null,onload_start:null,onload_end:null,onunload_start:null,onunload_end:null,autoBindCustomButtons:false,zIndex:null,defaults:{applyDemoStyles:false,closable:true,resizable:true,slidable:true,initClosed:false,initHidden:false,contentSelector:".ui-layout-content",contentIgnoreSelector:".ui-layout-ignore",findNestedContent:false,paneClass:"ui-layout-pane",resizerClass:"ui-layout-resizer",togglerClass:"ui-layout-toggler",buttonClass:"ui-layout-button",minSize:0,maxSize:0,spacing_open:6,spacing_closed:6,togglerLength_open:50,togglerLength_closed:50,togglerAlign_open:"center",togglerAlign_closed:"center",togglerTip_open:lang.Close,togglerTip_closed:lang.Open,togglerContent_open:"",togglerContent_closed:"",resizerDblClickToggle:true,autoResize:true,autoReopen:true,resizerDragOpacity:1,maskIframesOnResize:true,resizeNestedLayout:true,resizeWhileDragging:false,resizeContentWhileDragging:false,noRoomToOpenTip:lang.msgNoRoom,resizerTip:lang.Resize,sliderTip:lang.Slide,sliderCursor:"pointer",slideTrigger_open:"click",slideTrigger_close:"mouseleave",slideDelay_open:300,slideDelay_close:300,hideTogglerOnSlide:false,preventQuickSlideClose:!!($.browser.webkit||$.browser.safari),preventPrematureSlideClose:false,showOverflowOnHover:false,enableCursorHotkey:true,customHotkeyModifier:"SHIFT",fxName:"slide",fxSpeed:null,fxSettings:{},fxOpacityFix:true,triggerEventsOnLoad:false,triggerEventsWhileDragging:true,onshow_start:null,onshow_end:null,onhide_start:null,onhide_end:null,onopen_start:null,onopen_end:null,onclose_start:null,onclose_end:null,onresize_start:null,onresize_end:null,onsizecontent_start:null,onsizecontent_end:null,onswap_start:null,onswap_end:null,ondrag_start:null,ondrag_end:null},north:{paneSelector:".ui-layout-north",size:"auto",resizerCursor:"n-resize",customHotkey:""},south:{paneSelector:".ui-layout-south",size:"auto",resizerCursor:"s-resize",customHotkey:""},east:{paneSelector:".ui-layout-east",size:200,resizerCursor:"e-resize",customHotkey:""},west:{paneSelector:".ui-layout-west",size:200,resizerCursor:"w-resize",customHotkey:""},center:{paneSelector:".ui-layout-center",minWidth:0,minHeight:0},useStateCookie:false,cookie:{name:"",autoSave:true,autoLoad:true,domain:"",path:"",expires:"",secure:false,keys:"north.size,south.size,east.size,west.size,"+"north.isClosed,south.isClosed,east.isClosed,west.isClosed,"+"north.isHidden,south.isHidden,east.isHidden,west.isHidden"}};var effects={slide:{all:{duration:"fast"},north:{direction:"up"},south:{direction:"down"},east:{direction:"right"},west:{direction:"left"}},drop:{all:{duration:"slow"},north:{direction:"up"},south:{direction:"down"},east:{direction:"right"},west:{direction:"left"}},scale:{all:{duration:"fast"}}};var state={id:"layout"+new Date().getTime(),initialized:false,container:{},north:{},south:{},east:{},west:{},center:{},cookie:{}};var _c={allPanes:"north,south,west,east,center",borderPanes:"north,south,west,east",altSide:{north:"south",south:"north",east:"west",west:"east"},hidden:{visibility:"hidden"},visible:{visibility:"visible"},zIndex:{pane_normal:1,resizer_normal:2,iframe_mask:2,pane_sliding:100,pane_animate:1000,resizer_drag:10000},resizers:{cssReq:{position:"absolute",padding:0,margin:0,fontSize:"1px",textAlign:"left",overflow:"hidden"},cssDemo:{background:"#DDD",border:"none"}},togglers:{cssReq:{position:"absolute",display:"block",padding:0,margin:0,overflow:"hidden",textAlign:"center",fontSize:"1px",cursor:"pointer",zIndex:1},cssDemo:{background:"#AAA"}},content:{cssReq:{position:"relative"},cssDemo:{overflow:"auto",padding:"10px"},cssDemoPane:{overflow:"hidden",padding:0}},panes:{cssReq:{position:"absolute",margin:0},cssDemo:{padding:"10px",background:"#FFF",border:"1px solid #BBB",overflow:"auto"}},north:{side:"Top",sizeType:"Height",dir:"horz",cssReq:{top:0,bottom:"auto",left:0,right:0,width:"auto"},pins:[]},south:{side:"Bottom",sizeType:"Height",dir:"horz",cssReq:{top:"auto",bottom:0,left:0,right:0,width:"auto"},pins:[]},east:{side:"Right",sizeType:"Width",dir:"vert",cssReq:{left:"auto",right:0,top:"auto",bottom:"auto",height:"auto"},pins:[]},west:{side:"Left",sizeType:"Width",dir:"vert",cssReq:{left:0,right:"auto",top:"auto",bottom:"auto",height:"auto"},pins:[]},center:{dir:"center",cssReq:{left:"auto",right:"auto",top:"auto",bottom:"auto",height:"auto",width:"auto"}}};var timer={data:{},set:function(s,fn,ms){timer.clear(s);timer.data[s]=setTimeout(fn,ms);},clear:function(s){var t=timer.data;if(t[s]){clearTimeout(t[s]);delete t[s];}}};var isStr=function(o){try{return typeof o=="string"||(typeof o=="object"&&o.constructor.toString().match(/string/i)!==null);}
catch(e){return false;}};var str=function(o){return isStr(o)?$.trim(o):o==undefined||o==null?"":o;};var min=function(x,y){return Math.min(x,y);};var max=function(x,y){return Math.max(x,y);};var _transformData=function(d){var a,json={cookie:{},defaults:{fxSettings:{}},north:{fxSettings:{}},south:{fxSettings:{}},east:{fxSettings:{}},west:{fxSettings:{}},center:{fxSettings:{}}};d=d||{};if(d.effects||d.cookie||d.defaults||d.north||d.south||d.west||d.east||d.center)
json=$.extend(true,json,d);else
$.each(d,function(key,val){a=key.split("__");if(!a[1]||json[a[0]])
json[a[1]?a[0]:"defaults"][a[1]?a[1]:a[0]]=val;});return json;};var _queue=function(action,pane,param){var tried=[];$.each(_c.borderPanes.split(","),function(i,p){if(_c[p].isMoving){bindCallback(p);return false;}});function bindCallback(p){var c=_c[p];if(!c.doCallback){c.doCallback=true;c.callback=action+","+pane+","+(param?1:0);}
else{tried.push(p);var cbPane=c.callback.split(",")[1];if(cbPane!=pane&&!$.inArray(cbPane,tried)>=0)
bindCallback(cbPane);}}};var _dequeue=function(pane){var c=_c[pane];_c.isLayoutBusy=false;delete c.isMoving;if(!c.doCallback||!c.callback)return;c.doCallback=false;var
cb=c.callback.split(","),param=(cb[2]>0?true:false);if(cb[0]=="open")
open(cb[1],param);else if(cb[0]=="close")
close(cb[1],param);if(!c.doCallback)c.callback=null;};var _execCallback=function(pane,v_fn){if(!v_fn)return;var fn;try{if(typeof v_fn=="function")
fn=v_fn;else if(!isStr(v_fn))
return;else if(v_fn.match(/,/)){var args=v_fn.split(",");fn=eval(args[0]);if(typeof fn=="function"&&args.length>1)
return fn(args[1]);}
else
fn=eval(v_fn);if(typeof fn=="function"){if(pane&&$Ps[pane])
return fn(pane,$Ps[pane],$.extend({},state[pane]),options[pane],options.name);else
return fn(Instance,$.extend({},state),options,options.name);}}
catch(ex){}};var _showInvisibly=function($E,force){if(!$E)return{};if(!$E.jquery)$E=$($E);var CSS={display:$E.css('display'),visibility:$E.css('visibility')};if(force||CSS.display=="none"){$E.css({display:"block",visibility:"hidden"});return CSS;}
else return{};};var _fixIframe=function(pane){if(state.browser.mozilla)return;var $P=$Ps[pane];if(state[pane].tagName=="IFRAME")
$P.css(_c.hidden).css(_c.visible);else
$P.find('IFRAME').css(_c.hidden).css(_c.visible);};var _cssNum=function($E,prop){if(!$E.jquery)$E=$($E);var CSS=_showInvisibly($E);var val=parseInt($.curCSS($E[0],prop,true),10)||0;$E.css(CSS);return val;};var _borderWidth=function(E,side){if(E.jquery)E=E[0];var b="border"+side.substr(0,1).toUpperCase()+side.substr(1);return $.curCSS(E,b+"Style",true)=="none"?0:(parseInt($.curCSS(E,b+"Width",true),10)||0);};var cssW=function(el,outerWidth){var
str=isStr(el),$E=str?$Ps[el]:$(el);if(isNaN(outerWidth))
outerWidth=str?getPaneSize(el):$E.outerWidth();if(outerWidth<=0)return 0;if(!state.browser.boxModel)return outerWidth;var W=outerWidth
-_borderWidth($E,"Left")
-_borderWidth($E,"Right")
-_cssNum($E,"paddingLeft")
-_cssNum($E,"paddingRight");return max(0,W);};var cssH=function(el,outerHeight){var
str=isStr(el),$E=str?$Ps[el]:$(el);if(isNaN(outerHeight))
outerHeight=str?getPaneSize(el):$E.outerHeight();if(outerHeight<=0)return 0;if(!state.browser.boxModel)return outerHeight;var H=outerHeight
-_borderWidth($E,"Top")
-_borderWidth($E,"Bottom")
-_cssNum($E,"paddingTop")
-_cssNum($E,"paddingBottom");return max(0,H);};var cssSize=function(pane,outerSize){if(_c[pane].dir=="horz")
return cssH(pane,outerSize);else
return cssW(pane,outerSize);};var cssMinDims=function(pane){var
dir=_c[pane].dir,d={minWidth:1001-cssW(pane,1000),minHeight:1001-cssH(pane,1000)};if(dir=="horz")d.minSize=d.minHeight;if(dir=="vert")d.minSize=d.minWidth;return d;};var setOuterWidth=function(el,outerWidth,autoHide){var $E=el,w;if(isStr(el))$E=$Ps[el];else if(!el.jquery)$E=$(el);w=cssW($E,outerWidth);$E.css({width:w});if(w>0){if(autoHide&&$E.data('autoHidden')&&$E.innerHeight()>0){$E.show().data('autoHidden',false);if(!state.browser.mozilla)
$E.css(_c.hidden).css(_c.visible);}}
else if(autoHide&&!$E.data('autoHidden'))
$E.hide().data('autoHidden',true);};var setOuterHeight=function(el,outerHeight,autoHide){var $E=el,h;if(isStr(el))$E=$Ps[el];else if(!el.jquery)$E=$(el);h=cssH($E,outerHeight);$E.css({height:h,visibility:"visible"});if(h>0&&$E.innerWidth()>0){if(autoHide&&$E.data('autoHidden')){$E.show().data('autoHidden',false);if(!state.browser.mozilla)
$E.css(_c.hidden).css(_c.visible);}}
else if(autoHide&&!$E.data('autoHidden'))
$E.hide().data('autoHidden',true);};var setOuterSize=function(el,outerSize,autoHide){if(_c[pane].dir=="horz")
setOuterHeight(el,outerSize,autoHide);else
setOuterWidth(el,outerSize,autoHide);};var _parseSize=function(pane,size,dir){if(!dir)dir=_c[pane].dir;if(isStr(size)&&size.match(/%/))
size=parseInt(size,10)/100;if(size===0)
return 0;else if(size>=1)
return parseInt(size,10);else if(size>0){var o=options,avail;if(dir=="horz")
avail=sC.innerHeight-($Ps.north?o.north.spacing_open:0)-($Ps.south?o.south.spacing_open:0);else if(dir=="vert")
avail=sC.innerWidth-($Ps.west?o.west.spacing_open:0)-($Ps.east?o.east.spacing_open:0);return Math.floor(avail*size);}
else if(pane=="center")
return 0;else{var
$P=$Ps[pane],dim=(dir=="horz"?"height":"width"),vis=_showInvisibly($P),s=$P.css(dim);;$P.css(dim,"auto");size=(dim=="height")?$P.outerHeight():$P.outerWidth();$P.css(dim,s).css(vis);return size;}};var getPaneSize=function(pane,inclSpace){var
$P=$Ps[pane],o=options[pane],s=state[pane],oSp=(inclSpace?o.spacing_open:0),cSp=(inclSpace?o.spacing_closed:0);if(!$P||s.isHidden)
return 0;else if(s.isClosed||(s.isSliding&&inclSpace))
return cSp;else if(_c[pane].dir=="horz")
return $P.outerHeight()+oSp;else
return $P.outerWidth()+oSp;};var setSizeLimits=function(pane,slide){var
o=options[pane],s=state[pane],c=_c[pane],dir=c.dir,side=c.side.toLowerCase(),type=c.sizeType.toLowerCase(),isSliding=(slide!=undefined?slide:s.isSliding),$P=$Ps[pane],paneSpacing=o.spacing_open,altPane=_c.altSide[pane],altS=state[altPane],$altP=$Ps[altPane],altPaneSize=(!$altP||altS.isVisible===false||altS.isSliding?0:(dir=="horz"?$altP.outerHeight():$altP.outerWidth())),altPaneSpacing=((!$altP||altS.isHidden?0:options[altPane][altS.isClosed!==false?"spacing_closed":"spacing_open"])||0),containerSize=(dir=="horz"?sC.innerHeight:sC.innerWidth),minCenterDims=cssMinDims("center"),minCenterSize=dir=="horz"?max(options.center.minHeight,minCenterDims.minHeight):max(options.center.minWidth,minCenterDims.minWidth),limitSize=(containerSize-paneSpacing-(isSliding?0:(_parseSize("center",minCenterSize,dir)+altPaneSize+altPaneSpacing))),minSize=s.minSize=max(_parseSize(pane,o.minSize),cssMinDims(pane).minSize),maxSize=s.maxSize=min((o.maxSize?_parseSize(pane,o.maxSize):100000),limitSize),r=s.resizerPosition={},top=sC.insetTop,left=sC.insetLeft,W=sC.innerWidth,H=sC.innerHeight,rW=o.spacing_open;switch(pane){case"north":r.min=top+minSize;r.max=top+maxSize;break;case"west":r.min=left+minSize;r.max=left+maxSize;break;case"south":r.min=top+H-maxSize-rW;r.max=top+H-minSize-rW;break;case"east":r.min=left+W-maxSize-rW;r.max=left+W-minSize-rW;break;};};var calcNewCenterPaneDims=function(){var d={top:getPaneSize("north",true),bottom:getPaneSize("south",true),left:getPaneSize("west",true),right:getPaneSize("east",true),width:0,height:0};d.width=sC.innerWidth-d.left-d.right;d.height=sC.innerHeight-d.bottom-d.top;d.top+=sC.insetTop;d.bottom+=sC.insetBottom;d.left+=sC.insetLeft;d.right+=sC.insetRight;return d;};var getElemDims=function($E){var
d={},x=d.css={},i={},b,p,off=$E.offset();d.offsetLeft=off.left;d.offsetTop=off.top;$.each("Left,Right,Top,Bottom".split(","),function(idx,e){b=x["border"+e]=_borderWidth($E,e);p=x["padding"+e]=_cssNum($E,"padding"+e);i[e]=b+p;d["inset"+e]=p;});d.offsetWidth=$E.innerWidth();d.offsetHeight=$E.innerHeight();d.outerWidth=$E.outerWidth();d.outerHeight=$E.outerHeight();d.innerWidth=d.outerWidth-i.Left-i.Right;d.innerHeight=d.outerHeight-i.Top-i.Bottom;x.width=$E.width();x.height=$E.height();return d;};var getElemCSS=function($E,list){var
CSS={},style=$E[0].style,props=list.split(","),sides="Top,Bottom,Left,Right".split(","),attrs="Color,Style,Width".split(","),p,s,a,i,j,k;for(i=0;i<props.length;i++){p=props[i];if(p.match(/(border|padding|margin)$/))
for(j=0;j<4;j++){s=sides[j];if(p=="border")
for(k=0;k<3;k++){a=attrs[k];CSS[p+s+a]=style[p+s+a];}
else
CSS[p+s]=style[p+s];}
else
CSS[p]=style[p];};return CSS};var getHoverClasses=function(el,allStates){var
$El=$(el),type=$El.data("layoutRole"),pane=$El.data("layoutEdge"),o=options[pane],root=o[type+"Class"],_pane="-"+pane,_open="-open",_closed="-closed",_slide="-sliding",_hover="-hover ",_state=$El.hasClass(root+_closed)?_closed:_open,_alt=_state==_closed?_open:_closed,classes=(root+_hover)+(root+_pane+_hover)+(root+_state+_hover)+(root+_pane+_state+_hover);if(allStates)
classes+=(root+_alt+_hover)+(root+_pane+_alt+_hover);if(type=="resizer"&&$El.hasClass(root+_slide))
classes+=(root+_slide+_hover)+(root+_pane+_slide+_hover);return $.trim(classes);};var addHover=function(evt,el){var $E=$(el||this);if(evt&&$E.data("layoutRole")=="toggler")
evt.stopPropagation();$E.addClass(getHoverClasses($E));};var removeHover=function(evt,el){var $E=$(el||this);$E.removeClass(getHoverClasses($E,true));};var onResizerEnter=function(evt){$('body').disableSelection();addHover(evt,this);};var onResizerLeave=function(evt,el){var
e=el||this,pane=$(e).data("layoutEdge"),name=pane+"ResizerLeave";timer.clear(pane+"_openSlider");timer.clear(name);if(!el){removeHover(evt,this);timer.set(name,function(){onResizerLeave(evt,e);},200);}
else if(!state[pane].isResizing)
$('body').enableSelection();};var _create=function(){initOptions();var o=options;if(false===_execCallback(null,o.onload_start))return false;if(!getPane('center').length){alert(lang.errCenterPaneMissing);return null;}
if(o.useStateCookie&&o.cookie.autoLoad)
loadCookie();state.browser={mozilla:$.browser.mozilla,webkit:$.browser.webkit||$.browser.safari,msie:$.browser.msie,isIE6:$.browser.msie&&$.browser.version==6,boxModel:$.support.boxModel};initContainer();initPanes();sizeContent();if(o.scrollToBookmarkOnLoad){var l=self.location;if(l.hash)l.replace(l.hash);}
initHotkeys();if(o.autoBindCustomButtons)initButtons();if(o.resizeWithWindow&&!$Container.data("layoutRole"))
$(window).bind("resize."+sID,windowResize);$(window).bind("unload."+sID,unload);state.initialized=true;_execCallback(null,o.onload_end||o.onload);};var windowResize=function(){var delay=Number(options.resizeWithWindowDelay)||100;if(delay>0){timer.clear("winResize");timer.set("winResize",function(){timer.clear("winResize");timer.clear("winResizeRepeater");resizeAll();},delay);if(!timer.data["winResizeRepeater"])setWindowResizeRepeater();}};var setWindowResizeRepeater=function(){var delay=Number(options.resizeWithWindowMaxDelay);if(delay>0)
timer.set("winResizeRepeater",function(){setWindowResizeRepeater();resizeAll();},delay);};var unload=function(){var o=options;state.cookie=getState();_execCallback(null,o.onunload_start);if(o.useStateCookie&&o.cookie.autoSave)saveCookie();_execCallback(null,o.onunload_end||o.onunload);};var initContainer=function(){var
$C=$Container,tag=sC.tagName=$C.attr("tagName"),fullPage=(tag=="BODY"),props="position,margin,padding,border",CSS={};sC.selector=$C.selector.split(".slice")[0];sC.ref=tag+"/"+sC.selector;$C.data("layout",Instance).data("layoutContainer",sID).addClass(options.containerClass);if(!$C.data("layoutCSS")){if(fullPage){CSS=$.extend(getElemCSS($C,props),{height:$C.css("height"),overflow:$C.css("overflow"),overflowX:$C.css("overflowX"),overflowY:$C.css("overflowY")});var $H=$("html");$H.data("layoutCSS",{height:"auto",overflow:$H.css("overflow"),overflowX:$H.css("overflowX"),overflowY:$H.css("overflowY")});}
else
CSS=getElemCSS($C,props+",top,bottom,left,right,width,height,overflow,overflowX,overflowY");$C.data("layoutCSS",CSS);}
try{if(fullPage){$("html").css({height:"100%",overflow:"hidden",overflowX:"hidden",overflowY:"hidden"});$("body").css({position:"relative",height:"100%",overflow:"hidden",overflowX:"hidden",overflowY:"hidden",margin:0,padding:0,border:"none"});}
else{CSS={overflow:"hidden"}
var
p=$C.css("position"),h=$C.css("height");if(!$C.data("layoutRole")){if(!p||!p.match(/fixed|absolute|relative/))
CSS.position="relative";}
$C.css(CSS);if($C.is(":visible")&&$C.innerHeight()<2)
alert(lang.errContainerHeight.replace(/CONTAINER/,sC.ref));}}catch(ex){}
$.extend(state.container,getElemDims($C));};var initHotkeys=function(panes){if(!panes||panes=="all")panes=_c.borderPanes;$.each(panes.split(","),function(i,pane){var o=options[pane];if(o.enableCursorHotkey||o.customHotkey){$(document).bind("keydown."+sID,keyDown);return false;}});};var initOptions=function(){opts=_transformData(opts);var newOpts={applyDefaultStyles:"applyDemoStyles"};renameOpts(opts.defaults);$.each(_c.allPanes.split(","),function(i,pane){renameOpts(opts[pane]);});if(opts.effects){$.extend(effects,opts.effects);delete opts.effects;}
$.extend(options.cookie,opts.cookie);var globals="name,containerClass,zIndex,scrollToBookmarkOnLoad,resizeWithWindow,resizeWithWindowDelay,resizeWithWindowMaxDelay,"+"onresizeall,onresizeall_start,onresizeall_end,onload,onload_start,onload_end,onunload,onunload_start,onunload_end,autoBindCustomButtons,useStateCookie";$.each(globals.split(","),function(i,key){if(opts[key]!==undefined)
options[key]=opts[key];else if(opts.defaults[key]!==undefined){options[key]=opts.defaults[key];delete opts.defaults[key];}});$.each("paneSelector,resizerCursor,customHotkey".split(","),function(i,key){delete opts.defaults[key];});$.extend(true,options.defaults,opts.defaults);_c.center=$.extend(true,{},_c.panes,_c.center);var z=options.zIndex;if(z===0||z>0){_c.zIndex.pane_normal=z;_c.zIndex.resizer_normal=z+1;_c.zIndex.iframe_mask=z+1;}
$.extend(options.center,opts.center);var o_Center=$.extend(true,{},options.defaults,opts.defaults,options.center);var optionsCenter=("paneClass,contentSelector,applyDemoStyles,triggerEventsOnLoad,showOverflowOnHover,"
+"onresize,onresize_start,onresize_end,resizeNestedLayout,resizeContentWhileDragging,"
+"onsizecontent,onsizecontent_start,onsizecontent_end").split(",");$.each(optionsCenter,function(i,key){options.center[key]=o_Center[key];});var o,defs=options.defaults;$.each(_c.borderPanes.split(","),function(i,pane){_c[pane]=$.extend(true,{},_c.panes,_c[pane]);o=options[pane]=$.extend(true,{},options.defaults,options[pane],opts.defaults,opts[pane]);if(!o.paneClass)o.paneClass="ui-layout-pane";if(!o.resizerClass)o.resizerClass="ui-layout-resizer";if(!o.togglerClass)o.togglerClass="ui-layout-toggler";$.each(["_open","_close",""],function(i,n){var
sName="fxName"+n,sSpeed="fxSpeed"+n,sSettings="fxSettings"+n;o[sName]=opts[pane][sName]||opts[pane].fxName||opts.defaults[sName]||opts.defaults.fxName||o[sName]||o.fxName||defs[sName]||defs.fxName||"none";var fxName=o[sName];if(fxName=="none"||!$.effects||!$.effects[fxName]||(!effects[fxName]&&!o[sSettings]&&!o.fxSettings))
fxName=o[sName]="none";var
fx=effects[fxName]||{},fx_all=fx.all||{},fx_pane=fx[pane]||{};o[sSettings]=$.extend({},fx_all,fx_pane,defs.fxSettings||{},defs[sSettings]||{},o.fxSettings,o[sSettings],opts.defaults.fxSettings,opts.defaults[sSettings]||{},opts[pane].fxSettings,opts[pane][sSettings]||{});o[sSpeed]=opts[pane][sSpeed]||opts[pane].fxSpeed||opts.defaults[sSpeed]||opts.defaults.fxSpeed||o[sSpeed]||o[sSettings].duration||o.fxSpeed||o.fxSettings.duration||defs.fxSpeed||defs.fxSettings.duration||fx_pane.duration||fx_all.duration||"normal";});});function renameOpts(O){for(var key in newOpts){if(O[key]!=undefined){O[newOpts[key]]=O[key];delete O[key];}}}};var getPane=function(pane){var sel=options[pane].paneSelector
if(sel.substr(0,1)==="#")
return $Container.find(sel).eq(0);else{var $P=$Container.children(sel).eq(0);return $P.length?$P:$Container.children("form:first").children(sel).eq(0);}};var initPanes=function(){$.each(_c.allPanes.split(","),function(idx,pane){addPane(pane);});initHandles();$.each(_c.borderPanes.split(","),function(i,pane){if($Ps[pane]&&state[pane].isVisible){setSizeLimits(pane);makePaneFit(pane);}});sizeMidPanes("center");$.each(_c.allPanes.split(","),function(i,pane){var o=options[pane];if($Ps[pane]&&state[pane].isVisible){if(o.triggerEventsOnLoad)
_execCallback(pane,o.onresize_end||o.onresize);resizeNestedLayout(pane);}});if($Container.innerHeight()<2)
alert(lang.errContainerHeight.replace(/CONTAINER/,sC.ref));};var addPane=function(pane){var
o=options[pane],s=state[pane],c=_c[pane],fx=s.fx,dir=c.dir,spacing=o.spacing_open||0,isCenter=(pane=="center"),CSS={},$P=$Ps[pane],size,minSize,maxSize;if($P)
removePane(pane);else
$Cs[pane]=false;$P=$Ps[pane]=getPane(pane);if(!$P.length){$Ps[pane]=false;return;}
if(!$P.data("layoutCSS")){var props="position,top,left,bottom,right,width,height,overflow,zIndex,display,backgroundColor,padding,margin,border";$P.data("layoutCSS",getElemCSS($P,props));}
$P.data("parentLayout",Instance).data("layoutRole","pane").data("layoutEdge",pane).css(c.cssReq).css("zIndex",_c.zIndex.pane_normal).css(o.applyDemoStyles?c.cssDemo:{}).addClass(o.paneClass+" "+o.paneClass+"-"+pane).bind("mouseenter."+sID,addHover).bind("mouseleave."+sID,removeHover);initContent(pane,false);if(!isCenter){size=s.size=_parseSize(pane,o.size);minSize=_parseSize(pane,o.minSize)||1;maxSize=_parseSize(pane,o.maxSize)||100000;if(size>0)size=max(min(size,maxSize),minSize);s.isClosed=false;s.isSliding=false;s.isResizing=false;s.isHidden=false;}
s.tagName=$P.attr("tagName");s.edge=pane
s.noRoom=false;s.isVisible=true;switch(pane){case"north":CSS.top=sC.insetTop;CSS.left=sC.insetLeft;CSS.right=sC.insetRight;break;case"south":CSS.bottom=sC.insetBottom;CSS.left=sC.insetLeft;CSS.right=sC.insetRight;break;case"west":CSS.left=sC.insetLeft;break;case"east":CSS.right=sC.insetRight;break;case"center":}
if(dir=="horz")
CSS.height=max(1,cssH(pane,size));else if(dir=="vert")
CSS.width=max(1,cssW(pane,size));$P.css(CSS);if(dir!="horz")sizeMidPanes(pane,true);if(!s.noRoom)
$P.css({visibility:"visible",display:"block"});if(o.initClosed&&o.closable)
close(pane,true,true);else if(o.initHidden||o.initClosed)
hide(pane);if(o.showOverflowOnHover)
$P.hover(allowOverflow,resetOverflow);if(state.initialized){initHandles(pane);initHotkeys(pane);resizeAll();if(s.isVisible){if(o.triggerEventsOnLoad)
_execCallback(pane,o.onresize_end||o.onresize);resizeNestedLayout(pane);}}};var initHandles=function(panes){if(!panes||panes=="all")panes=_c.borderPanes;$.each(panes.split(","),function(i,pane){var $P=$Ps[pane];$Rs[pane]=false;$Ts[pane]=false;if(!$P)return;var
o=options[pane],s=state[pane],c=_c[pane],rClass=o.resizerClass,tClass=o.togglerClass,side=c.side.toLowerCase(),spacing=(s.isVisible?o.spacing_open:o.spacing_closed),_pane="-"+pane,_state=(s.isVisible?"-open":"-closed"),$R=$Rs[pane]=$("<div></div>"),$T=(o.closable?$Ts[pane]=$("<div></div>"):false);if(!s.isVisible&&o.slidable)
$R.attr("title",o.sliderTip).css("cursor",o.sliderCursor);$R.attr("id",(o.paneSelector.substr(0,1)=="#"?o.paneSelector.substr(1)+"-resizer":"")).data("parentLayout",Instance).data("layoutRole","resizer").data("layoutEdge",pane).css(_c.resizers.cssReq).css("zIndex",_c.zIndex.resizer_normal).css(o.applyDemoStyles?_c.resizers.cssDemo:{}).addClass(rClass+" "+rClass+_pane).appendTo($Container);if($T){$T.attr("id",(o.paneSelector.substr(0,1)=="#"?o.paneSelector.substr(1)+"-toggler":"")).data("parentLayout",Instance).data("layoutRole","toggler").data("layoutEdge",pane).css(_c.togglers.cssReq).css(o.applyDemoStyles?_c.togglers.cssDemo:{}).addClass(tClass+" "+tClass+_pane).appendTo($R);if(o.togglerContent_open)
$("<span>"+o.togglerContent_open+"</span>").data("layoutRole","togglerContent").data("layoutEdge",pane).addClass("content content-open").css("display","none").appendTo($T);if(o.togglerContent_closed)
$("<span>"+o.togglerContent_closed+"</span>").data("layoutRole","togglerContent").data("layoutEdge",pane).addClass("content content-closed").css("display","none").appendTo($T);enableClosable(pane);}
initResizable(pane);if(s.isVisible)
setAsOpen(pane);else{setAsClosed(pane);bindStartSlidingEvent(pane,true);}});sizeHandles("all");};var initContent=function(pane,resize){var
o=options[pane],sel=o.contentSelector,$P=$Ps[pane],$C;if(sel)$C=$Cs[pane]=(o.findNestedContent)?$P.find(sel).eq(0):$P.children(sel).eq(0);if($C&&$C.length){if(!$C.data("layoutCSS"))
$C.data("layoutCSS",getElemCSS($C,"height"));$C.css(_c.content.cssReq);if(o.applyDemoStyles){$C.css(_c.content.cssDemo);$P.css(_c.content.cssDemoPane);}
state[pane].content={};if(resize!==false)sizeContent(pane);}
else
$Cs[pane]=false;};var initButtons=function(){var pre="ui-layout-button-",name;$.each("toggle,open,close,pin,toggle-slide,open-slide".split(","),function(i,action){$.each(_c.borderPanes.split(","),function(ii,pane){$("."+pre+action+"-"+pane).each(function(){name=$(this).data("layoutName")||$(this).attr("layoutName");if(name==undefined||name==options.name)
bindButton(this,action,pane);});});});};var initResizable=function(panes){var
draggingAvailable=(typeof $.fn.draggable=="function"),$Frames,side;if(!panes||panes=="all")panes=_c.borderPanes;$.each(panes.split(","),function(idx,pane){var
o=options[pane],s=state[pane],c=_c[pane],side=(c.dir=="horz"?"top":"left"),r,live;if(!draggingAvailable||!$Ps[pane]||!o.resizable){o.resizable=false;return true;}
var
$P=$Ps[pane],$R=$Rs[pane],base=o.resizerClass,resizerClass=base+"-drag",resizerPaneClass=base+"-"+pane+"-drag",helperClass=base+"-dragging",helperPaneClass=base+"-"+pane+"-dragging",helperLimitClass=base+"-dragging-limit",helperPaneLimitClass=base+"-"+pane+"-dragging-limit",helperClassesSet=false;if(!s.isClosed)
$R.attr("title",o.resizerTip).css("cursor",o.resizerCursor);$R.bind("mouseenter."+sID,onResizerEnter).bind("mouseleave."+sID,onResizerLeave);$R.draggable({containment:$Container[0],axis:(c.dir=="horz"?"y":"x"),delay:0,distance:1,helper:"clone",opacity:o.resizerDragOpacity,addClasses:false,zIndex:_c.zIndex.resizer_drag,start:function(e,ui){o=options[pane];s=state[pane];live=o.resizeWhileDragging;if(false===_execCallback(pane,o.ondrag_start))return false;_c.isLayoutBusy=true;s.isResizing=true;timer.clear(pane+"_closeSlider");setSizeLimits(pane);r=s.resizerPosition;$R.addClass(resizerClass+" "+resizerPaneClass);helperClassesSet=false;$Frames=$(o.maskIframesOnResize===true?"iframe":o.maskIframesOnResize).filter(":visible");var id,i=0;$Frames.each(function(){id="ui-layout-mask-"+(++i);$(this).data("layoutMaskID",id);$('<div id="'+id+'" class="ui-layout-mask ui-layout-mask-'+pane+'"/>').css({background:"#fff",opacity:"0.001",zIndex:_c.zIndex.iframe_mask,position:"absolute",width:this.offsetWidth+"px",height:this.offsetHeight+"px"}).css($(this).position()).appendTo(this.parentNode);});$('body').disableSelection();},drag:function(e,ui){if(!helperClassesSet){ui.helper.addClass(helperClass+" "+helperPaneClass).css({right:"auto",bottom:"auto"}).children().css("visibility","hidden");helperClassesSet=true;if(s.isSliding)$Ps[pane].css("zIndex",_c.zIndex.pane_sliding);}
var limit=0;if(ui.position[side]<r.min){ui.position[side]=r.min;limit=-1;}
else if(ui.position[side]>r.max){ui.position[side]=r.max;limit=1;}
if(limit){ui.helper.addClass(helperLimitClass+" "+helperPaneLimitClass);window.defaultStatus="Panel has reached its "+
((limit>0&&pane.match(/north|west/))||(limit<0&&pane.match(/south|east/))?"maximum":"minimum")+" size";}
else{ui.helper.removeClass(helperLimitClass+" "+helperPaneLimitClass);window.defaultStatus="";}
if(live)resizePanes(e,ui,pane);},stop:function(e,ui){$('body').enableSelection();window.defaultStatus="";$R.removeClass(resizerClass+" "+resizerPaneClass);s.isResizing=false;_c.isLayoutBusy=false;resizePanes(e,ui,pane,true);}});var resizePanes=function(evt,ui,pane,resizingDone){var
dragPos=ui.position,c=_c[pane],resizerPos,newSize,i=0;switch(pane){case"north":resizerPos=dragPos.top;break;case"west":resizerPos=dragPos.left;break;case"south":resizerPos=sC.offsetHeight-dragPos.top-o.spacing_open;break;case"east":resizerPos=sC.offsetWidth-dragPos.left-o.spacing_open;break;};if(resizingDone){$("div.ui-layout-mask").each(function(){this.parentNode.removeChild(this);});if(false===_execCallback(pane,o.ondrag_end||o.ondrag))return false;}
else
$Frames.each(function(){$("#"+$(this).data("layoutMaskID")).css($(this).position()).css({width:this.offsetWidth+"px",height:this.offsetHeight+"px"});});newSize=resizerPos-sC["inset"+c.side];manualSizePane(pane,newSize);}});};var destroy=function(){$(window).unbind("."+sID);$(document).unbind("."+sID);$.each(_c.allPanes.split(","),function(i,pane){removePane(pane,false,true);});var $C=$Container.removeData("layout").removeData("layoutContainer").removeClass(options.containerClass);if(!$C.data("layoutEdge")&&$C.data("layoutCSS"))
$C.css($C.data("layoutCSS")).removeData("layoutCSS");if(sC.tagName=="BODY"&&($C=$("html")).data("layoutCSS"))
$C.css($C.data("layoutCSS")).removeData("layoutCSS");unload();};var removePane=function(pane,remove,skipResize){if(!$Ps[pane])return;var
$P=$Ps[pane],$C=$Cs[pane],$R=$Rs[pane],$T=$Ts[pane],_open="-open",_sliding="-sliding",_closed="-closed",root=options[pane].paneClass,pRoot=root+"-"+pane,classes=[root,root+_open,root+_closed,root+_sliding,pRoot,pRoot+_open,pRoot+_closed,pRoot+_sliding];$.merge(classes,getHoverClasses($P,true));if(!$P||!$P.length){}
else if(remove&&!$P.data("layoutContainer")&&(!$C||!$C.length||!$C.data("layoutContainer")))
$P.remove();else{$P.removeClass(classes.join(" ")).removeData("layoutParent").removeData("layoutRole").removeData("layoutEdge").removeData("autoHidden").unbind("."+sID);if(!$P.data("layoutContainer"))
$P.css($P.data("layoutCSS")).removeData("layoutCSS");if($C&&$C.length&&!$C.data("layoutContainer"))
$C.css($C.data("layoutCSS")).removeData("layoutCSS");}
if($T&&$T.length)$T.remove();if($R&&$R.length)$R.remove();$Ps[pane]=$Cs[pane]=$Rs[pane]=$Ts[pane]=false;if(!skipResize){resizeAll();state[pane]={};}};var hide=function(pane,noAnimation){var
o=options[pane],s=state[pane],$P=$Ps[pane],$R=$Rs[pane];if(!$P||s.isHidden)return;if(state.initialized&&false===_execCallback(pane,o.onhide_start))return;s.isSliding=false;if($R)$R.hide();if(!state.initialized||s.isClosed){s.isClosed=true;s.isHidden=true;s.isVisible=false;$P.hide();sizeMidPanes(_c[pane].dir=="horz"?"all":"center");if(state.initialized||o.triggerEventsOnLoad)
_execCallback(pane,o.onhide_end||o.onhide);}
else{s.isHiding=true;close(pane,false,noAnimation);}};var show=function(pane,openPane,noAnimation,noAlert){var
o=options[pane],s=state[pane],$P=$Ps[pane],$R=$Rs[pane];if(!$P||!s.isHidden)return;if(false===_execCallback(pane,o.onshow_start))return;s.isSliding=false;s.isShowing=true;if(openPane===false)
close(pane,true);else
open(pane,false,noAnimation,noAlert);};var toggle=function(pane,slide){if(!isStr(pane)){pane.stopImmediatePropagation();pane=$(this).data("layoutEdge");}
var s=state[str(pane)];if(s.isHidden)
show(pane);else if(s.isClosed)
open(pane,!!slide);else
close(pane);};var _closePane=function(pane,setHandles){var
$P=$Ps[pane],s=state[pane];$P.hide();s.isClosed=true;s.isVisible=false;};var close=function(pane,force,noAnimation,skipCallback){if(!state.initialized){_closePane(pane)
return;}
var
$P=$Ps[pane],$R=$Rs[pane],$T=$Ts[pane],o=options[pane],s=state[pane],doFX=!noAnimation&&!s.isClosed&&(o.fxName_close!="none"),isShowing=s.isShowing,isHiding=s.isHiding,wasSliding=s.isSliding;delete s.isShowing;delete s.isHiding;if(!$P||(!o.closable&&!isShowing&&!isHiding))return;else if(!force&&s.isClosed&&!isShowing)return;if(_c.isLayoutBusy){_queue("close",pane,force);return;}
if(!isShowing&&false===_execCallback(pane,o.onclose_start))return;_c[pane].isMoving=true;_c.isLayoutBusy=true;s.isClosed=true;s.isVisible=false;if(isHiding)s.isHidden=true;else if(isShowing)s.isHidden=false;if(s.isSliding)
bindStopSlidingEvents(pane,false);else
sizeMidPanes(_c[pane].dir=="horz"?"all":"center",false);setAsClosed(pane);if(doFX){lockPaneForFX(pane,true);$P.hide(o.fxName_close,o.fxSettings_close,o.fxSpeed_close,function(){lockPaneForFX(pane,false);close_2();});}
else{$P.hide();close_2();};function close_2(){if(s.isClosed){bindStartSlidingEvent(pane,true);var altPane=_c.altSide[pane];if(state[altPane].noRoom){setSizeLimits(altPane);makePaneFit(altPane);}
if(!skipCallback&&(state.initialized||o.triggerEventsOnLoad)){if(!isShowing)_execCallback(pane,o.onclose_end||o.onclose);if(isShowing)_execCallback(pane,o.onshow_end||o.onshow);if(isHiding)_execCallback(pane,o.onhide_end||o.onhide);}}
_dequeue(pane);}};var setAsClosed=function(pane){var
$P=$Ps[pane],$R=$Rs[pane],$T=$Ts[pane],o=options[pane],s=state[pane],side=_c[pane].side.toLowerCase(),inset="inset"+_c[pane].side,rClass=o.resizerClass,tClass=o.togglerClass,_pane="-"+pane,_open="-open",_sliding="-sliding",_closed="-closed";$R.css(side,sC[inset]).removeClass(rClass+_open+" "+rClass+_pane+_open).removeClass(rClass+_sliding+" "+rClass+_pane+_sliding).addClass(rClass+_closed+" "+rClass+_pane+_closed).unbind("dblclick."+sID);if(o.resizable&&typeof $.fn.draggable=="function")
$R.draggable("disable").removeClass("ui-state-disabled").css("cursor","default").attr("title","");if($T){$T.removeClass(tClass+_open+" "+tClass+_pane+_open).addClass(tClass+_closed+" "+tClass+_pane+_closed).attr("title",o.togglerTip_closed);$T.children(".content-open").hide();$T.children(".content-closed").css("display","block");}
syncPinBtns(pane,false);if(state.initialized){sizeHandles("all");}};var open=function(pane,slide,noAnimation,noAlert){var
$P=$Ps[pane],$R=$Rs[pane],$T=$Ts[pane],o=options[pane],s=state[pane],doFX=!noAnimation&&s.isClosed&&(o.fxName_open!="none"),isShowing=s.isShowing;delete s.isShowing;if(!$P||(!o.resizable&&!o.closable&&!isShowing))return;else if(s.isVisible&&!s.isSliding)return;if(s.isHidden&&!isShowing){show(pane,true);return;}
if(_c.isLayoutBusy){_queue("open",pane,slide);return;}
setSizeLimits(pane,slide);if(false===_execCallback(pane,o.onopen_start))return;if(s.minSize>s.maxSize){syncPinBtns(pane,false);if(!noAlert&&o.noRoomToOpenTip)alert(o.noRoomToOpenTip);return;}
_c[pane].isMoving=true;_c.isLayoutBusy=true;if(slide)
bindStopSlidingEvents(pane,true);else if(s.isSliding)
bindStopSlidingEvents(pane,false);else if(o.slidable)
bindStartSlidingEvent(pane,false);s.noRoom=false;makePaneFit(pane);s.isVisible=true;s.isClosed=false;if(isShowing)s.isHidden=false;if(doFX){lockPaneForFX(pane,true);$P.show(o.fxName_open,o.fxSettings_open,o.fxSpeed_open,function(){lockPaneForFX(pane,false);open_2();});}
else{$P.show();open_2();};function open_2(){if(s.isVisible){_fixIframe(pane);if(!s.isSliding)
sizeMidPanes(_c[pane].dir=="vert"?"center":"all",false);setAsOpen(pane);}
_dequeue(pane);};};var setAsOpen=function(pane,skipCallback){var
$P=$Ps[pane],$R=$Rs[pane],$T=$Ts[pane],o=options[pane],s=state[pane],side=_c[pane].side.toLowerCase(),inset="inset"+_c[pane].side,rClass=o.resizerClass,tClass=o.togglerClass,_pane="-"+pane,_open="-open",_closed="-closed",_sliding="-sliding";$R.css(side,sC[inset]+getPaneSize(pane)).removeClass(rClass+_closed+" "+rClass+_pane+_closed).addClass(rClass+_open+" "+rClass+_pane+_open);if(s.isSliding)
$R.addClass(rClass+_sliding+" "+rClass+_pane+_sliding)
else
$R.removeClass(rClass+_sliding+" "+rClass+_pane+_sliding)
if(o.resizerDblClickToggle)
$R.bind("dblclick",toggle);removeHover(0,$R);if(o.resizable&&typeof $.fn.draggable=="function")
$R.draggable("enable").css("cursor",o.resizerCursor).attr("title",o.resizerTip);else if(!s.isSliding)
$R.css("cursor","default");if($T){$T.removeClass(tClass+_closed+" "+tClass+_pane+_closed).addClass(tClass+_open+" "+tClass+_pane+_open).attr("title",o.togglerTip_open);removeHover(0,$T);$T.children(".content-closed").hide();$T.children(".content-open").css("display","block");}
syncPinBtns(pane,!s.isSliding);$.extend(s,getElemDims($P));if(state.initialized){sizeHandles("all");sizeContent(pane,true);}
if(!skipCallback&&(state.initialized||o.triggerEventsOnLoad)&&$P.is(":visible")){_execCallback(pane,o.onopen_end||o.onopen);if(s.isShowing)_execCallback(pane,o.onshow_end||o.onshow);if(state.initialized){_execCallback(pane,o.onresize_end||o.onresize);resizeNestedLayout(pane);}}};var slideOpen=function(evt_or_pane){var
evt=isStr(evt_or_pane)?null:evt_or_pane,pane=evt?$(this).data("layoutEdge"):evt_or_pane,s=state[pane],delay=options[pane].slideDelay_open;if(evt)evt.stopImmediatePropagation();if(s.isClosed&&evt&&evt.type=="mouseenter"&&delay>0)
timer.set(pane+"_openSlider",open_NOW,delay);else
open_NOW();function open_NOW(evt){if(!s.isClosed)
bindStopSlidingEvents(pane,true);else if(!_c[pane].isMoving)
open(pane,true);};};var slideClose=function(evt_or_pane){var
evt=isStr(evt_or_pane)?null:evt_or_pane,pane=evt?$(this).data("layoutEdge"):evt_or_pane,o=options[pane],s=state[pane],delay=_c[pane].isMoving?1000:300;if(s.isClosed||s.isResizing)
return;else if(o.slideTrigger_close=="click")
close_NOW();else if(o.preventQuickSlideClose&&_c.isLayoutBusy)
return;else if(o.preventPrematureSlideClose&&evt&&$.layout.isMouseOverElem(evt,$Ps[pane]))
return;else if(evt)
timer.set(pane+"_closeSlider",close_NOW,max(o.slideDelay_close,delay));else
close_NOW();function close_NOW(){if(s.isClosed)
bindStopSlidingEvents(pane,false);else if(!_c[pane].isMoving)
close(pane);};};var slideToggle=function(pane){toggle(pane,true);};var lockPaneForFX=function(pane,doLock){var $P=$Ps[pane];if(doLock){$P.css({zIndex:_c.zIndex.pane_animate});if(pane=="south")
$P.css({top:sC.insetTop+sC.innerHeight-$P.outerHeight()});else if(pane=="east")
$P.css({left:sC.insetLeft+sC.innerWidth-$P.outerWidth()});}
else{$P.css({zIndex:(state[pane].isSliding?_c.zIndex.pane_sliding:_c.zIndex.pane_normal)});if(pane=="south")
$P.css({top:"auto"});else if(pane=="east")
$P.css({left:"auto"});var o=options[pane];if(state.browser.msie&&o.fxOpacityFix&&o.fxName_open!="slide"&&$P.css("filter")&&$P.css("opacity")==1)
$P[0].style.removeAttribute('filter');}};var bindStartSlidingEvent=function(pane,enable){var
o=options[pane],$P=$Ps[pane],$R=$Rs[pane],trigger=o.slideTrigger_open.toLowerCase();if(!$R||(enable&&!o.slidable))return;if(trigger.match(/mouseover/))
trigger=o.slideTrigger_open="mouseenter";else if(!trigger.match(/click|dblclick|mouseenter/))
trigger=o.slideTrigger_open="click";$R
[enable?"bind":"unbind"](trigger+'.'+sID,slideOpen).css("cursor",enable?o.sliderCursor:"default").attr("title",enable?o.sliderTip:"");};var bindStopSlidingEvents=function(pane,enable){var
o=options[pane],s=state[pane],z=_c.zIndex,trigger=o.slideTrigger_close.toLowerCase(),action=(enable?"bind":"unbind"),$P=$Ps[pane],$R=$Rs[pane];s.isSliding=enable;timer.clear(pane+"_closeSlider");if(enable)bindStartSlidingEvent(pane,false);$P.css("zIndex",enable?z.pane_sliding:z.pane_normal);$R.css("zIndex",enable?z.pane_sliding:z.resizer_normal);if(!trigger.match(/click|mouseleave/))
trigger=o.slideTrigger_close="mouseleave";$R[action](trigger,slideClose);if(trigger=="mouseleave"){$P[action]("mouseleave."+sID,slideClose);$R[action]("mouseenter."+sID,cancelMouseOut);$P[action]("mouseenter."+sID,cancelMouseOut);}
if(!enable)
timer.clear(pane+"_closeSlider");else if(trigger=="click"&&!o.resizable){$R.css("cursor",enable?o.sliderCursor:"default");$R.attr("title",enable?o.togglerTip_open:"");}
function cancelMouseOut(evt){timer.clear(pane+"_closeSlider");evt.stopPropagation();}};var makePaneFit=function(pane,isOpening,skipCallback,force){var
o=options[pane],s=state[pane],c=_c[pane],$P=$Ps[pane],$R=$Rs[pane],isSidePane=c.dir=="vert",hasRoom=false;if(pane=="center"||(isSidePane&&s.noVerticalRoom)){hasRoom=(s.maxHeight>0);if(hasRoom&&s.noRoom){$P.show();if($R)$R.show();s.isVisible=true;s.noRoom=false;if(isSidePane)s.noVerticalRoom=false;_fixIframe(pane);}
else if(!hasRoom&&!s.noRoom){$P.hide();if($R)$R.hide();s.isVisible=false;s.noRoom=true;}}
if(pane=="center"){}
else if(s.minSize<=s.maxSize){hasRoom=true;if(s.size>s.maxSize)
sizePane(pane,s.maxSize,skipCallback,force);else if(s.size<s.minSize)
sizePane(pane,s.minSize,skipCallback,force);else if($R&&$P.is(":visible")){var
side=c.side.toLowerCase(),pos=s.size+sC["inset"+c.side];if(_cssNum($R,side)!=pos)$R.css(side,pos);}
if(s.noRoom){if(s.wasOpen&&o.closable){if(o.autoReopen)
open(pane,false,true,true);else
s.noRoom=false;}
else
show(pane,s.wasOpen,true,true);}}
else{if(!s.noRoom){s.noRoom=true;s.wasOpen=!s.isClosed&&!s.isSliding;if(s.isClosed){}
else if(o.closable)
close(pane,true,true);else
hide(pane,true);}}};var manualSizePane=function(pane,size,skipCallback){var
o=options[pane],forceResize=o.resizeWhileDragging&&!_c.isLayoutBusy;o.autoResize=false;sizePane(pane,size,skipCallback,forceResize);}
var sizePane=function(pane,size,skipCallback,force){var
o=options[pane],s=state[pane],$P=$Ps[pane],$R=$Rs[pane],side=_c[pane].side.toLowerCase(),inset="inset"+_c[pane].side,skipResizeWhileDragging=_c.isLayoutBusy&&!o.triggerEventsWhileDragging,oldSize;setSizeLimits(pane);oldSize=s.size;size=_parseSize(pane,size);size=max(size,_parseSize(pane,o.minSize));size=min(size,s.maxSize);if(size<s.minSize){makePaneFit(pane,false,skipCallback);return;}
if(!force&&size==oldSize)return;if(!skipCallback&&state.initialized&&s.isVisible)
_execCallback(pane,o.onresize_start);$P.css(_c[pane].sizeType.toLowerCase(),max(1,cssSize(pane,size)));s.size=size;$.extend(s,getElemDims($P));if($R&&$P.is(":visible"))$R.css(side,size+sC[inset]);sizeContent(pane);if(!skipCallback&&!skipResizeWhileDragging&&state.initialized&&s.isVisible){_execCallback(pane,o.onresize_end||o.onresize);resizeNestedLayout(pane);}
if(!skipCallback){if(!s.isSliding)sizeMidPanes(_c[pane].dir=="horz"?"all":"center",skipResizeWhileDragging,force);sizeHandles("all");}
var altPane=_c.altSide[pane];if(size<oldSize&&state[altPane].noRoom){setSizeLimits(altPane);makePaneFit(altPane,false,skipCallback);}};var sizeMidPanes=function(panes,skipCallback,force){if(!panes||panes=="all")panes="east,west,center";$.each(panes.split(","),function(i,pane){if(!$Ps[pane])return;var
o=options[pane],s=state[pane],$P=$Ps[pane],$R=$Rs[pane],isCenter=(pane=="center"),hasRoom=true,CSS={},d=calcNewCenterPaneDims();$.extend(s,getElemDims($P));if(pane=="center"){if(!force&&s.isVisible&&d.width==s.outerWidth&&d.height==s.outerHeight)
return true;$.extend(s,cssMinDims(pane),{maxWidth:d.width,maxHeight:d.height});CSS=d;CSS.width=cssW(pane,d.width);CSS.height=cssH(pane,d.height);hasRoom=CSS.width>0&&CSS.height>0;if(!hasRoom&&!state.initialized&&o.minWidth>0){var
reqPx=o.minWidth-s.outerWidth,minE=options.east.minSize||0,minW=options.west.minSize||0,sizeE=state.east.size,sizeW=state.west.size,newE=sizeE,newW=sizeW;if(reqPx>0&&state.east.isVisible&&sizeE>minE){newE=max(sizeE-minE,sizeE-reqPx);reqPx-=sizeE-newE;}
if(reqPx>0&&state.west.isVisible&&sizeW>minW){newW=max(sizeW-minW,sizeW-reqPx);reqPx-=sizeW-newW;}
if(reqPx==0){if(sizeE!=minE)
sizePane('east',newE,true);if(sizeW!=minW)
sizePane('west',newW,true);sizeMidPanes('center',skipCallback,force);return;}}}
else{if(s.isVisible&&!s.noVerticalRoom)
$.extend(s,getElemDims($P),cssMinDims(pane))
if(!force&&!s.noVerticalRoom&&d.height==s.outerHeight)
return true;CSS.top=d.top;CSS.bottom=d.bottom;CSS.height=cssH(pane,d.height);s.maxHeight=max(0,CSS.height);hasRoom=(s.maxHeight>0);if(!hasRoom)s.noVerticalRoom=true;}
if(hasRoom){if(!skipCallback&&state.initialized)
_execCallback(pane,o.onresize_start);$P.css(CSS);if(s.noRoom&&!s.isClosed&&!s.isHidden)
makePaneFit(pane);if(s.isVisible){$.extend(s,getElemDims($P));if(state.initialized)sizeContent(pane);}}
else if(!s.noRoom&&s.isVisible)
makePaneFit(pane);if(!s.isVisible)
return true;if(pane=="center"){var b=state.browser;var fix=b.isIE6||(b.msie&&!b.boxModel);if($Ps.north&&(fix||state.north.tagName=="IFRAME"))
$Ps.north.css("width",cssW($Ps.north,sC.innerWidth));if($Ps.south&&(fix||state.south.tagName=="IFRAME"))
$Ps.south.css("width",cssW($Ps.south,sC.innerWidth));}
if(!skipCallback&&state.initialized){_execCallback(pane,o.onresize_end||o.onresize);resizeNestedLayout(pane);}});};var resizeAll=function(){var
oldW=sC.innerWidth,oldH=sC.innerHeight;$.extend(state.container,getElemDims($Container));if(!sC.outerHeight)return;if(false===_execCallback(null,options.onresizeall_start))return false;var
shrunkH=(sC.innerHeight<oldH),shrunkW=(sC.innerWidth<oldW),$P,o,s,dir;$.each(["south","north","east","west"],function(i,pane){if(!$Ps[pane])return;s=state[pane];o=options[pane];dir=_c[pane].dir;if(o.autoResize&&s.size!=o.size)
sizePane(pane,o.size,true,true);else{setSizeLimits(pane);makePaneFit(pane,false,true,true);}});sizeMidPanes("all",true,true);sizeHandles("all");o=options;$.each(_c.allPanes.split(","),function(i,pane){$P=$Ps[pane];if(!$P)return;if(state[pane].isVisible){_execCallback(pane,o[pane].onresize_end||o[pane].onresize);resizeNestedLayout(pane);}});_execCallback(null,o.onresizeall_end||o.onresizeall);};var resizeNestedLayout=function(pane){var
$P=$Ps[pane],$C=$Cs[pane],d="layoutContainer";if(options[pane].resizeNestedLayout){if($P.data(d))
$P.layout().resizeAll();else if($C&&$C.data(d))
$C.layout().resizeAll();}};var sizeContent=function(panes,remeasure){if(!panes||panes=="all")panes=_c.allPanes;$.each(panes.split(","),function(idx,pane){var
$P=$Ps[pane],$C=$Cs[pane],o=options[pane],s=state[pane],m=s.content;if(!$P||!$C||!$P.is(":visible"))return true;if(false===_execCallback(null,o.onsizecontent_start))return;if(!_c.isLayoutBusy||m.top==undefined||remeasure||o.resizeContentWhileDragging){_measure();if(m.hiddenFooters>0&&$P.css("overflow")=="hidden"){$P.css("overflow","visible");_measure();$P.css("overflow","hidden");}}
var newH=s.innerHeight-(m.spaceAbove-s.css.paddingTop)-(m.spaceBelow-s.css.paddingBottom);if(!$C.is(":visible")||m.height!=newH){setOuterHeight($C,newH,true);m.height=newH;};if(state.initialized){_execCallback(pane,o.onsizecontent_end||o.onsizecontent);resizeNestedLayout(pane);}
function _below($E){return max(s.css.paddingBottom,(parseInt($E.css("marginBottom"),10)||0));};function _measure(){var
ignore=options[pane].contentIgnoreSelector,$Fs=$C.nextAll().not(ignore||':lt(0)'),$Fs_vis=$Fs.filter(':visible'),$F=$Fs_vis.filter(':last');m={top:$C[0].offsetTop,height:$C.outerHeight(),numFooters:$Fs.length,hiddenFooters:$Fs.length-$Fs_vis.length,spaceBelow:0}
m.spaceAbove=m.top;m.bottom=m.top+m.height;if($F.length)
m.spaceBelow=($F[0].offsetTop+$F.outerHeight())-m.bottom+_below($F);else
m.spaceBelow=_below($C);};});};var sizeHandles=function(panes){if(!panes||panes=="all")panes=_c.borderPanes;$.each(panes.split(","),function(i,pane){var
o=options[pane],s=state[pane],$P=$Ps[pane],$R=$Rs[pane],$T=$Ts[pane],$TC;if(!$P||!$R)return;var
dir=_c[pane].dir,_state=(s.isClosed?"_closed":"_open"),spacing=o["spacing"+_state],togAlign=o["togglerAlign"+_state],togLen=o["togglerLength"+_state],paneLen,offset,CSS={};if(spacing==0){$R.hide();return;}
else if(!s.noRoom&&!s.isHidden)
$R.show();if(dir=="horz"){paneLen=$P.outerWidth();s.resizerLength=paneLen;$R.css({width:max(1,cssW($R,paneLen)),height:max(0,cssH($R,spacing)),left:_cssNum($P,"left")});}
else{paneLen=$P.outerHeight();s.resizerLength=paneLen;$R.css({height:max(1,cssH($R,paneLen)),width:max(0,cssW($R,spacing)),top:sC.insetTop+getPaneSize("north",true)});}
removeHover(o,$R);if($T){if(togLen==0||(s.isSliding&&o.hideTogglerOnSlide)){$T.hide();return;}
else
$T.show();if(!(togLen>0)||togLen=="100%"||togLen>paneLen){togLen=paneLen;offset=0;}
else{if(isStr(togAlign)){switch(togAlign){case"top":case"left":offset=0;break;case"bottom":case"right":offset=paneLen-togLen;break;case"middle":case"center":default:offset=Math.floor((paneLen-togLen)/2);}}
else{var x=parseInt(togAlign,10);if(togAlign>=0)offset=x;else offset=paneLen-togLen+x;}}
if(dir=="horz"){var width=cssW($T,togLen);$T.css({width:max(0,width),height:max(1,cssH($T,spacing)),left:offset,top:0});$T.children(".content").each(function(){$TC=$(this);$TC.css("marginLeft",Math.floor((width-$TC.outerWidth())/2));});}
else{var height=cssH($T,togLen);$T.css({height:max(0,height),width:max(1,cssW($T,spacing)),top:offset,left:0});$T.children(".content").each(function(){$TC=$(this);$TC.css("marginTop",Math.floor((height-$TC.outerHeight())/2));});}
removeHover(0,$T);}
if(!state.initialized&&(o.initHidden||s.noRoom)){$R.hide();if($T)$T.hide();}});};var enableClosable=function(pane){var $T=$Ts[pane],o=options[pane];if(!$T)return;o.closable=true;$T.bind("click."+sID,function(evt){evt.stopPropagation();toggle(pane);}).bind("mouseenter."+sID,addHover).bind("mouseleave."+sID,removeHover).css("visibility","visible").css("cursor","pointer").attr("title",state[pane].isClosed?o.togglerTip_closed:o.togglerTip_open).show();};var disableClosable=function(pane,hide){var $T=$Ts[pane];if(!$T)return;options[pane].closable=false;if(state[pane].isClosed)open(pane,false,true);$T.unbind("."+sID).css("visibility",hide?"hidden":"visible").css("cursor","default").attr("title","");};var enableSlidable=function(pane){var $R=$Rs[pane],o=options[pane];if(!$R||!$R.data('draggable'))return;options[pane].slidable=true;if(s.isClosed)
bindStartSlidingEvent(pane,true);};var disableSlidable=function(pane){var $R=$Rs[pane];if(!$R)return;options[pane].slidable=false;if(state[pane].isSliding)
close(pane,false,true);else{bindStartSlidingEvent(pane,false);$R.css("cursor","default").attr("title","");removeHover(null,$R[0]);}};var enableResizable=function(pane){var $R=$Rs[pane],o=options[pane];if(!$R||!$R.data('draggable'))return;o.resizable=true;$R.draggable("enable").bind("mouseenter."+sID,onResizerEnter).bind("mouseleave."+sID,onResizerLeave);if(!state[pane].isClosed)
$R.css("cursor",o.resizerCursor).attr("title",o.resizerTip);};var disableResizable=function(pane){var $R=$Rs[pane];if(!$R||!$R.data('draggable'))return;options[pane].resizable=false;$R.draggable("disable").unbind("."+sID).css("cursor","default").attr("title","");removeHover(null,$R[0]);};var swapPanes=function(pane1,pane2){state[pane1].edge=pane2;state[pane2].edge=pane1;var cancelled=false;if(false===_execCallback(pane1,options[pane1].onswap_start))cancelled=true;if(!cancelled&&false===_execCallback(pane2,options[pane2].onswap_start))cancelled=true;if(cancelled){state[pane1].edge=pane1;state[pane2].edge=pane2;return;}
var
oPane1=copy(pane1),oPane2=copy(pane2),sizes={};sizes[pane1]=oPane1?oPane1.state.size:0;sizes[pane2]=oPane2?oPane2.state.size:0;$Ps[pane1]=false;$Ps[pane2]=false;state[pane1]={};state[pane2]={};if($Ts[pane1])$Ts[pane1].remove();if($Ts[pane2])$Ts[pane2].remove();if($Rs[pane1])$Rs[pane1].remove();if($Rs[pane2])$Rs[pane2].remove();$Rs[pane1]=$Rs[pane2]=$Ts[pane1]=$Ts[pane2]=false;move(oPane1,pane2);move(oPane2,pane1);oPane1=oPane2=sizes=null;if($Ps[pane1])$Ps[pane1].css(_c.visible);if($Ps[pane2])$Ps[pane2].css(_c.visible);resizeAll();_execCallback(pane1,options[pane1].onswap_end||options[pane1].onswap);_execCallback(pane2,options[pane2].onswap_end||options[pane2].onswap);return;function copy(n){var
$P=$Ps[n],$C=$Cs[n];return!$P?false:{pane:n,P:$P?$P[0]:false,C:$C?$C[0]:false,state:$.extend({},state[n]),options:$.extend({},options[n])}};function move(oPane,pane){if(!oPane)return;var
P=oPane.P,C=oPane.C,oldPane=oPane.pane,c=_c[pane],side=c.side.toLowerCase(),inset="inset"+c.side,s=$.extend({},state[pane]),o=options[pane],fx={resizerCursor:o.resizerCursor},re,size,pos;$.each("fxName,fxSpeed,fxSettings".split(","),function(i,k){fx[k]=o[k];fx[k+"_open"]=o[k+"_open"];fx[k+"_close"]=o[k+"_close"];});$Ps[pane]=$(P).data("layoutEdge",pane).css(_c.hidden).css(c.cssReq);$Cs[pane]=C?$(C):false;options[pane]=$.extend({},oPane.options,fx);state[pane]=$.extend({},oPane.state);re=new RegExp(o.paneClass+"-"+oldPane,"g");P.className=P.className.replace(re,o.paneClass+"-"+pane);initHandles(pane);if(c.dir!=_c[oldPane].dir){size=sizes[pane]||0;setSizeLimits(pane);size=max(size,state[pane].minSize);manualSizePane(pane,size,true);}
else
$Rs[pane].css(side,sC[inset]+(state[pane].isVisible?getPaneSize(pane):0));if(oPane.state.isVisible&&!s.isVisible)
setAsOpen(pane,true);else{setAsClosed(pane);bindStartSlidingEvent(pane,true);}
oPane=null;};};function keyDown(evt){if(!evt)return true;var code=evt.keyCode;if(code<33)return true;var
PANE={38:"north",40:"south",37:"west",39:"east"},ALT=evt.altKey,SHIFT=evt.shiftKey,CTRL=evt.ctrlKey,CURSOR=(CTRL&&code>=37&&code<=40),o,k,m,pane;if(CURSOR&&options[PANE[code]].enableCursorHotkey)
pane=PANE[code];else if(CTRL||SHIFT)
$.each(_c.borderPanes.split(","),function(i,p){o=options[p];k=o.customHotkey;m=o.customHotkeyModifier;if((SHIFT&&m=="SHIFT")||(CTRL&&m=="CTRL")||(CTRL&&SHIFT)){if(k&&code==(isNaN(k)||k<=9?k.toUpperCase().charCodeAt(0):k)){pane=p;return false;}}});if(!pane||!$Ps[pane]||!options[pane].closable||state[pane].isHidden)
return true;toggle(pane);evt.stopPropagation();evt.returnValue=false;return false;};function allowOverflow(el){if(this&&this.tagName)el=this;var $P;if(isStr(el))
$P=$Ps[el];else if($(el).data("layoutRole"))
$P=$(el);else
$(el).parents().each(function(){if($(this).data("layoutRole")){$P=$(this);return false;}});if(!$P||!$P.length)return;var
pane=$P.data("layoutEdge"),s=state[pane];if(s.cssSaved)
resetOverflow(pane);if(s.isSliding||s.isResizing||s.isClosed){s.cssSaved=false;return;}
var
newCSS={zIndex:(_c.zIndex.pane_normal+2)},curCSS={},of=$P.css("overflow"),ofX=$P.css("overflowX"),ofY=$P.css("overflowY");if(of!="visible"){curCSS.overflow=of;newCSS.overflow="visible";}
if(ofX&&!ofX.match(/visible|auto/)){curCSS.overflowX=ofX;newCSS.overflowX="visible";}
if(ofY&&!ofY.match(/visible|auto/)){curCSS.overflowY=ofX;newCSS.overflowY="visible";}
s.cssSaved=curCSS;$P.css(newCSS);$.each(_c.allPanes.split(","),function(i,p){if(p!=pane)resetOverflow(p);});};function resetOverflow(el){if(this&&this.tagName)el=this;var $P;if(isStr(el))
$P=$Ps[el];else if($(el).data("layoutRole"))
$P=$(el);else
$(el).parents().each(function(){if($(this).data("layoutRole")){$P=$(this);return false;}});if(!$P||!$P.length)return;var
pane=$P.data("layoutEdge"),s=state[pane],CSS=s.cssSaved||{};if(!s.isSliding&&!s.isResizing)
$P.css("zIndex",_c.zIndex.pane_normal);$P.css(CSS);s.cssSaved=false;};function getBtn(selector,pane,action){var $E=$(selector);if(!$E.length)
alert(lang.errButton+lang.selector+": "+selector);else if(_c.borderPanes.indexOf(pane)==-1)
alert(lang.errButton+lang.Pane.toLowerCase()+": "+pane);else{var btn=options[pane].buttonClass+"-"+action;$E.addClass(btn+" "+btn+"-"+pane).data("layoutName",options.name);return $E;}
return null;};function bindButton(selector,action,pane){switch(action.toLowerCase()){case"toggle":addToggleBtn(selector,pane);break;case"open":addOpenBtn(selector,pane);break;case"close":addCloseBtn(selector,pane);break;case"pin":addPinBtn(selector,pane);break;case"toggle-slide":addToggleBtn(selector,pane,true);break;case"open-slide":addOpenBtn(selector,pane,true);break;}};function addToggleBtn(selector,pane,slide){var $E=getBtn(selector,pane,"toggle");if($E)
$E.click(function(evt){toggle(pane,!!slide);evt.stopPropagation();});};function addOpenBtn(selector,pane,slide){var $E=getBtn(selector,pane,"open");if($E)
$E.attr("title",lang.Open).click(function(evt){open(pane,!!slide);evt.stopPropagation();});};function addCloseBtn(selector,pane){var $E=getBtn(selector,pane,"close");if($E)
$E.attr("title",lang.Close).click(function(evt){close(pane);evt.stopPropagation();});};function addPinBtn(selector,pane){var $E=getBtn(selector,pane,"pin");if($E){var s=state[pane];$E.click(function(evt){setPinState($(this),pane,(s.isSliding||s.isClosed));if(s.isSliding||s.isClosed)open(pane);else close(pane);evt.stopPropagation();});setPinState($E,pane,(!s.isClosed&&!s.isSliding));_c[pane].pins.push(selector);}};function syncPinBtns(pane,doPin){$.each(_c[pane].pins,function(i,selector){setPinState($(selector),pane,doPin);});};function setPinState($Pin,pane,doPin){var updown=$Pin.attr("pin");if(updown&&doPin==(updown=="down"))return;var
pin=options[pane].buttonClass+"-pin",side=pin+"-"+pane,UP=pin+"-up "+side+"-up",DN=pin+"-down "+side+"-down";$Pin.attr("pin",doPin?"down":"up").attr("title",doPin?lang.Unpin:lang.Pin).removeClass(doPin?UP:DN).addClass(doPin?DN:UP);};function isCookiesEnabled(){return(navigator.cookieEnabled!=0);};function getCookie(opts){var
o=$.extend({},options.cookie,opts||{}),name=o.name||options.name||"Layout",c=document.cookie,cs=c?c.split(';'):[],pair;for(var i=0,n=cs.length;i<n;i++){pair=$.trim(cs[i]).split('=');if(pair[0]==name)
return decodeJSON(decodeURIComponent(pair[1]));}
return"";};function saveCookie(keys,opts){var
o=$.extend({},options.cookie,opts||{}),name=o.name||options.name||"Layout",params='',date='',clear=false;if(o.expires.toUTCString)
date=o.expires;else if(typeof o.expires=='number'){date=new Date();if(o.expires>0)
date.setDate(date.getDate()+o.expires);else{date.setYear(1970);clear=true;}}
if(date)params+=';expires='+date.toUTCString();if(o.path)params+=';path='+o.path;if(o.domain)params+=';domain='+o.domain;if(o.secure)params+=';secure';if(clear){state.cookie={};document.cookie=name+'='+params;}
else{state.cookie=getState(keys||o.keys);document.cookie=name+'='+encodeURIComponent(encodeJSON(state.cookie))+params;}
return $.extend({},state.cookie);};function deleteCookie(){saveCookie('',{expires:-1});};function loadCookie(opts){var o=getCookie(opts);if(o){state.cookie=$.extend({},o);loadState(o);}
return o;};function loadState(opts,animate){$.extend(true,options,opts);if(state.initialized){var pane,o,v,a=!animate;$.each(_c.allPanes.split(","),function(idx,pane){o=opts[pane];if(typeof o!='object')return;v=o.initHidden;if(v===true)hide(pane,a);if(v===false)show(pane,false,a);v=o.size;if(v>0)sizePane(pane,v);v=o.initClosed;if(v===true)close(pane,false,a);if(v===false)open(pane,false,a);});}};function getState(keys){var
data={},alt={isClosed:'initClosed',isHidden:'initHidden'},pair,pane,key,val;if(!keys)keys=options.cookie.keys;if($.isArray(keys))keys=keys.join(",");keys=keys.replace(/__/g,".").split(',');for(var i=0,n=keys.length;i<n;i++){pair=keys[i].split(".");pane=pair[0];key=pair[1];if(_c.allPanes.indexOf(pane)<0)continue;val=state[pane][key];if(val==undefined)continue;if(key=="isClosed"&&state[pane]["isSliding"])
val=true;(data[pane]||(data[pane]={}))[alt[key]?alt[key]:key]=val;}
return data;};function encodeJSON(JSON){return parse(JSON);function parse(h){var D=[],i=0,k,v,t;for(k in h){v=h[k];t=typeof v;if(t=='string')
v='"'+v+'"';else if(t=='object')
v=parse(v);D[i++]='"'+k+'":'+v;}
return"{"+D.join(",")+"}";};};function decodeJSON(str){try{return window["eval"]("("+str+")")||{};}
catch(e){return{};}};var $Container=$(this).eq(0);if(!$Container.length){return null;};if($Container.data("layoutContainer")&&$Container.data("layout"))
return $Container.data("layout");var
$Ps={},$Cs={},$Rs={},$Ts={},sC=state.container,sID=state.id;var Instance={options:options,state:state,container:$Container,panes:$Ps,contents:$Cs,resizers:$Rs,togglers:$Ts,toggle:toggle,hide:hide,show:show,open:open,close:close,slideOpen:slideOpen,slideClose:slideClose,slideToggle:slideToggle,initContent:initContent,sizeContent:sizeContent,sizePane:manualSizePane,swapPanes:swapPanes,resizeAll:resizeAll,destroy:destroy,addPane:addPane,removePane:removePane,setSizeLimits:setSizeLimits,bindButton:bindButton,addToggleBtn:addToggleBtn,addOpenBtn:addOpenBtn,addCloseBtn:addCloseBtn,addPinBtn:addPinBtn,allowOverflow:allowOverflow,resetOverflow:resetOverflow,encodeJSON:encodeJSON,decodeJSON:decodeJSON,getState:getState,getCookie:getCookie,saveCookie:saveCookie,deleteCookie:deleteCookie,loadCookie:loadCookie,loadState:loadState,cssWidth:cssW,cssHeight:cssH,enableClosable:enableClosable,disableClosable:disableClosable,enableSlidable:enableSlidable,disableSlidable:disableSlidable,enableResizable:enableResizable,disableResizable:disableResizable};_create();return Instance;}})(jQuery);