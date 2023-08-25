### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 04efa7a2-f585-422b-96c5-0c11ceec3886
begin
	import Pkg
	Pkg.add("CommonMark")
	Pkg.add("HypertextLiteral")
	#Pkg.add(path="C://Users//snoeyink//git//HypertextLiteral.jl")
	Pkg.add(url="https://github.com/snoeyink/MarkdownLiteral.jl")
	Pkg.add("PlutoUI")
	Pkg.add("PlutoTest")
	Pkg.instantiate()
	import MarkdownLiteral: @mdx, @mdx_str
	using HypertextLiteral
	using CommonMark
	using PlutoUI
	using PlutoTest
end

# ╔═╡ 62dbc6d2-eda7-4696-b7c6-f5a7f0e7b252
cm"""
# Quantifier Diagrams

## Defining:

Let ``P`` be the set of points in a given diagram. For all ``p,q \in P``, let 
* ``d(p)`` be the statement "``p`` is a diamond,"
* ``b(p)`` be the statement  "``p`` is black," and
* ``D(p,q)`` be the statement "``(p.x > q.x) \land (p.y > q.y)``." 

## Interacting:
* Click on a point ``f`` to associate it with the <u>first</u> quantifier.
* Then, hover over a point ``s`` to associate it with the <u>second</u> quantifier.
* Click the point ``f`` again to unassociate it with the first quantifier.

## Interpreting:
* If a point ``f`` is associated with the first quantifier and ``D(f,s)`` is used, then the L containing points <u>dominated by ``f``</u> appears.
* If a point ``f`` is associated with the first quantifier and ``D(s,f)`` is used, then the L containing points that <u>dominate ``f``</u> appears.
* If a pair of points <u>``(f,s)`` does not satisfy the expression </u>, a <u>small X</u> appears <u>to the right of</u> ``s``.
* If a pair of points <u>``(f,s)`` does satisfy the expression </u>, a <u>small checkmark</u> appears <u>to the right of</u> ``s``.
* If you have <u>not checked enough points</u> ``s`` to conclude whether ``f`` satisfies the expression as the first quantifier, a <u>light blue dot</u> appears <u>to the left of</u>  ``f``.
* If you have checked enough points ``s`` to conclude that <u> ``f`` does not satisfy the expression</u> as the first quantifier, an <u>X</u> appears <u>to the left of</u>  ``f``.
* If you have checked enough points ``s`` to conclude that <u> ``f`` does satisfy the expression</u> as the first quantifier, a <u>checkmark</u> appears <u>to the left of</u>  ``f``.
* If you have checked enough points ``f`` to conclude that the <u>overall quantifier expression is false</u> for an entire grid of points, a <u>big X</u> appears <u>over</u> the grid.
* If you have checked enough points ``f`` to conclude that the <u>overall quantifier expression is true</u> for an entire grid of points, a <u>big checkmark</u> appears <u>over</u> the grid.
"""

# ╔═╡ 7f2b3abb-074c-4c2c-9340-3363d6d265c7
cm"""
## `` ∃_{p∈P}∃_{q∈P} \ d(p)∧b(q)∧D(p,q)``"""

# ╔═╡ ce1b567a-e944-4dc6-a489-b811dc10de4e
cm"""
## ``∃_{p∈P}∃_{q∈P} \ d(p)→(b(q)→D(p,q))``"""

# ╔═╡ 1bfb38f3-dcaf-49a4-82a6-7fce6bfb8177
cm"""
## ``∃_{p∈P}∀_{q∈P} \ d(p)∧b(q)∧D(p,q)``"""

# ╔═╡ 4b9c9166-7a2a-4e49-81fe-88909778c621
cm"""
## ``∃_{p∈P}∀_{q∈P} \ (d(p)∧b(q))→D(p,q)``"""

# ╔═╡ cdcbf0ff-6dec-412a-a5dd-999dab5d4965
cm"""
## ``∃_{p∈P}∀_{q∈P} \ d(p)∧(b(q)→D(p,q))``"""

# ╔═╡ 938dd6cf-1ed0-44a8-a73a-f911788e200c
cm"""
## ``∀_{p∈P}∃_{q∈P} \ (d(p)∧b(q))→D(p,q)``"""

# ╔═╡ 5981046a-84dd-426a-8fdd-550784364aff
cm"""
## ``∀_{p∈P}∃_{q∈P} \ d(p)→(b(q)∧D(p,q))``"""

# ╔═╡ 5fbbd8b2-28d8-4cee-8380-4bb274fd55cf
cm"""
## ``∀_{p∈P}∀_{q∈P} \ (d(p)∧b(q))→D(p,q)``"""

# ╔═╡ 2a74a4e8-9355-4d20-b41b-536765aeeba1
cm"""
## ``∃_{q∈P}∀_{p∈P} \ d(p)→(b(q)∧D(p,q))``"""

# ╔═╡ 5d1f0be1-844f-4cef-bdbd-c343af4116bd
cm"""
## ``∀_{q∈P}∃_{p∈P} \ d(p)∧(b(q)→D(p,q))``"""

# ╔═╡ aa4a54a2-89e2-4265-b81a-779bb36fc08a

html"""
<style>
main {
    max-width: 1900px;
}
.small{
font-size: 14px;
font-family: "Computer Modern";
}

.mathsize{
font-size: 14px;
}

.special{
  border-bottom: 2px solid #000;
}
</style>
"""

# ╔═╡ b4df5d67-1184-40b2-8557-64e39f3a59ac
function plotHiddenTruthVals(data,gridnumber,exprnum,width,upperBuffer,xbuffer,xspaceBefore)
	marks = []
	truthGap = 60
	for i in 1:3
			cx = xbuffer + xspaceBefore + truthGap*(i - 1)
			cy = upperBuffer - 10
			scale = .25


			T = @htl("""<polygon id="true $exprnum,$gridnumber,$i" points="$(cx-5*scale) $(cy),$(cx+scale*5) $(cy),$(cx+scale*5) $(cy-scale*40),$(cx+scale*20) $(cy-scale*40),$(cx+scale*20) $(cy-scale*50),$(cx-scale*20) $(cy-scale*50),$(cx-scale*20) $(cy-scale*40),$(cx-5*scale) $(cy-scale*40)" style=" fill: lightgreen; stroke:black; stroke-width:1; visibility:hidden"/>""")
	
			F = @htl("""<polygon id="false $exprnum,$gridnumber,$i" points="$(cx-15*scale) $(cy),$(cx-scale*5) $(cy),$(cx-scale*5) $(cy-scale*20),$(cx + scale*15) $(cy - scale*20),$(cx + scale*15) $(cy - scale*30),$(cx - scale*5) $(cy - scale*30),$(cx - scale*5) $(cy - scale*40),$(cx + scale*15) $(cy - scale*40),$(cx + scale*15) $(cy - scale*50),$(cx-15*scale) $(cy - scale*50)" style=" fill: red; stroke:black; stroke-width:1; visibility:hidden"/>""")
		
			append!(marks,[T])
			append!(marks,[F])
	end

	for i in 1:2
			cx = xbuffer + xspaceBefore + truthGap*(i - 1) + truthGap/2
			cy = upperBuffer
			scale = .5


			t = @htl("""<polygon id="little true $exprnum,$gridnumber,$i" points="$(cx-5*scale) $(cy),$(cx+scale*5) $(cy),$(cx+scale*5) $(cy-scale*40),$(cx+scale*20) $(cy-scale*40),$(cx+scale*20) $(cy-scale*50),$(cx-scale*20) $(cy-scale*50),$(cx-scale*20) $(cy-scale*40),$(cx-5*scale) $(cy-scale*40)" style=" fill: lightgreen; stroke:black; stroke-width:1; visibility:hidden"/>""")
	
			f = @htl("""<polygon id="little false $exprnum,$gridnumber,$i" points="$(cx-15*scale) $(cy),$(cx-scale*5) $(cy),$(cx-scale*5) $(cy-scale*20),$(cx + scale*15) $(cy - scale*20),$(cx + scale*15) $(cy - scale*30),$(cx - scale*5) $(cy - scale*30),$(cx - scale*5) $(cy - scale*40),$(cx + scale*15) $(cy - scale*40),$(cx + scale*15) $(cy - scale*50),$(cx-15*scale) $(cy - scale*50)" style=" fill: red; stroke:black; stroke-width:1; visibility:hidden"/>""")
		
			append!(marks,[t])
			append!(marks,[f])
	end
	return marks
end

# ╔═╡ 6021134f-f508-4c9b-ba84-e048ba6a5cba
function plotDominatingLines(data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,xtick,ytick,xspaceBefore,yspaceAfter,upperBuffer)
	marks = []
	for i in 1:size(data[:y])[1]
			cx = xbuffer + xspaceBefore + shapeWidth*(i - 1)
			cy = height - ybuffer - yspaceAfter - shapeWidth*(data[:y][i])
			normdom = @htl("""<polyline id="normalDom $exprnum,$gridnumber,$(i-1)" points="$(xbuffer),$(cy) $(cx),$(cy) $(cx),$(height - ybuffer)" style="visibility:hidden; fill:none; stroke:black; stroke-width:3" />""")
			invdom = @htl("""<polyline id="invDom $exprnum,$gridnumber,$(i-1)" points="$(width-xbuffer),$(cy) $(cx),$(cy) $(cx),$(upperBuffer)" style="visibility:hidden; fill:none; stroke:black; stroke-width:3" />""")
	
			append!(marks,[normdom])
			append!(marks,[invdom])
	end
	return marks
end

# ╔═╡ e6726386-5c9d-4f08-9ec9-e78fa108e39b
function plotHiddenXsandChecks(data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,xtick,ytick,xspaceBefore,yspaceAfter,upperBuffer)
	marks = []
	for i in 1:size(data[:y])[1]
			cx = xbuffer + xspaceBefore - shapeWidth/2 + shapeWidth*(i - 1)
			cy = height - ybuffer - yspaceAfter - shapeWidth*(data[:y][i])
			scale = .8

			placeholder = @htl("""<circle  id="placeholder $exprnum,$gridnumber,$(i-1)" cx=$(cx) cy=$(cy) r=5 style=" visibility:hidden; fill: cyan; stroke:cyan; stroke-width:0"/>""")


			check = @htl("""<polygon id="checkmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")
		

			x = @htl("""<polygon  id="x $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

			cx = cx + shapeWidth
			scale = .5
			smallCheck = @htl("""<polygon id="smallcheckmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)" style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

			smallx = @htl("""<polygon id="smallx $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

		
			append!(marks,[check])
			append!(marks,[smallCheck])
			append!(marks,[x])
			append!(marks,[smallx])
			append!(marks,[placeholder])
	end
	cx = width/2
	cy = upperBuffer-shapeWidth
	scale=1
	bigCheck = @htl("""<polygon id="bigcheckmark $exprnum,$gridnumber" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

	bigX = @htl("""<polygon  id="bigx $exprnum,$gridnumber" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

	append!(marks,[bigCheck])
	append!(marks,[bigX])
	return marks
end

# ╔═╡ 3f52af75-c390-4423-9b52-a52c81791c92
function plotPoints(data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,xtick,ytick,xspaceBefore,yspaceAfter)
	dots = []
	for i in 1:size(data[:y])[1]
			cx = xbuffer + xspaceBefore + shapeWidth*(i - 1)
			cy = height - ybuffer - yspaceAfter - shapeWidth*(data[:y][i])
			shape = data[:marker][i]
			color = data[:fcolor][i]

			if shape == "d"
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),d" points="$(cx) $(cy-15),$(cx+10) $(cy),$(cx) $(cy+15),$(cx-10) $(cy)" onmouseleave = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill: $(color); stroke:black; stroke-width:2"/>""")
			elseif shape == "o"
				dot = @htl("""<circle id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),o" cx=$(cx) cy=$(cy) r=10 onmouseleave = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2" />""")
			elseif (shape == "x") || (shape == "X")
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),X" points="$(cx) $(cy-5),$(cx+5) $(cy-10),$(cx+10) $(cy-5),$(cx+5) $(cy),$(cx+10) $(cy+5),$(cx+5) $(cy+10),$(cx) $(cy+5),$(cx-5) $(cy+10),$(cx-10) $(cy+5),$(cx-5) $(cy),$(cx-10) $(cy-5),$(cx-5) $(cy-10)" onmouseleave = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2"/>""")
			else
				dot = "error"
				@assert(false)
			end
			append!(dots,[dot])
	end
	return dots
end

# ╔═╡ 0606bc8c-5132-4b17-8348-2b0358650041
##this function makes the assumption that there are at most five grids
htl"""
<script type="text/javascript"
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
<script>
//CLARIFICATION: I know this was a confusing way to code this, but the variable pointp just refers to the variable associated with the first quantifier (not necessarily the point that is labeled p). I started coding this before I allowed for the possibility of naming the variable associated with the first quantifier something other than p.

//These variables are specific to having five grids
var pchosen =  [[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false]]
var pval = [[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1]]

var qchosen = [[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false]]

var qval = [[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1],
			[-1,-1,-1,-1,-1]]

var qvals = [[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]]]

var shownSymbols = [[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]],
					[[],[],[],[],[]]]

var pointp = [[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]]]

var pointq = [[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]],
			[[],[],[],[],[]]]

var numqchecks = [[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]]

var numqxs =  [[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]]

var hiddenShownSymbols = [[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]],
						[[],[],[],[],[]]]

var numxs = [[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0],
		[0,0,0,0,0]]

var numchecks = [[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0],
			[0,0,0,0,0]]

var activatedp = [[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false],
				[false,false,false,false,false]]

//This function reveals an x or check over the point that was just clicked. It also puts a p or q on the shape to label it
//This function places a big or little check or x above the p or q that you click on.
window.putCheckorX = function(event)
{
	var exprnum = event.target.parentElement.parentElement.parentElement.id;
	var numOfPoints = ((event.target.parentElement.parentElement.id).split(",")[1]).split(" ")[1];
	//get the p selected (if there is one) and all the qs that are currently selected (if there are any).  Use the variables pchosen and qvals.length to figure out if any are selected.
	getPsQs(event)
	
	//getting info about the point I clicked
	var index = event.target.getAttributeNS(null,"id");
	var gridnumber = index.split(',')[1];
	const elem = document.getElementById(index);

	//If the point is p and I have just unclicked it, hide the symbol that was above //it and hide the symbols that were above any q's.
	if(pchosen[exprnum][gridnumber - 1] == false){
		activatedp[exprnum][gridnumber - 1] = false
		shownSymbols[exprnum][gridnumber - 1] = removeItemOnce(shownSymbols[exprnum][gridnumber - 1],index)
		removeAllSymbols(shownSymbols,gridnumber - 1,exprnum)
		numqchecks[exprnum][gridnumber-1] = 0
		numqxs[exprnum][gridnumber-1] = 0
		clearEveryTruthVal(exprnum,gridnumber)
	}

	//If the point is p and I have just clicked it, figure out what symbol to put above it:
else if((pval[exprnum][gridnumber - 1] == index) && (event.type == "click") && !(activatedp[exprnum][gridnumber - 1])){
		activatedp[exprnum][gridnumber - 1] = true
		//	If the statement is vacuously true, place a big check.
		if(vacTrue(pointp,exprnum,gridnumber)){
		var checkindex = "checkmark " + exprnum + "," + gridnumber + "," + index.split(',')[2];
		document.getElementById(checkindex).style.visibility = "visible"
		if (!(hiddenShownSymbols[exprnum][gridnumber - 1].includes(checkindex))){
			hiddenShownSymbols[exprnum][gridnumber - 1].push(checkindex)
			numchecks[exprnum][gridnumber - 1] += 1
		}
		}
		//	ElIf the statement is vacuously false, place a big X.
else if(vacFalse(pointp,exprnum,gridnumber)){
			var xindex = "x " + exprnum + "," + gridnumber + "," + index.split(',')[2];
			document.getElementById(xindex).style.visibility = "visible"
			//shownSymbols[exprnum][gridnumber - 1].push(xindex)
			if (!(hiddenShownSymbols[exprnum][gridnumber - 1].includes(xindex))){
					hiddenShownSymbols[exprnum][gridnumber - 1].push(xindex)
					numxs[exprnum][gridnumber - 1] += 1
				}

			}
		//	Else place same placeholder symbol to indicate that this is p but we are //still looking for a q to satisfy the expression.
		else{
			if (!(hiddenShownSymbols[exprnum][gridnumber - 1].includes("checkmark " + exprnum + "," + gridnumber + "," + index.split(',')[2])) && (!(hiddenShownSymbols[exprnum][gridnumber - 1].includes("x " + exprnum + "," + gridnumber + "," + index.split(',')[2])))){
			var placeholderindex = "placeholder " + exprnum + "," + gridnumber + "," + index.split(',')[2];
			document.getElementById(placeholderindex).style.visibility = "visible"
			shownSymbols[exprnum][gridnumber - 1].push(placeholderindex)
		}
			
			}
		//add its dominating L or inverse dominating L
		if(["8","9"].includes(exprnum)){
		var Lindex = "invDom " + exprnum + "," + gridnumber + "," + index.split(',')[2];
		}
		else{
		var Lindex = "normalDom " + exprnum + "," + gridnumber + "," + index.split(',')[2];
		}
		document.getElementById(Lindex).style.visibility = "visible"
		shownSymbols[exprnum][gridnumber - 1].push(Lindex)
		setFirstQuantifierTruthVals(pointp,pointq,exprnum,gridnumber)
		
	}
//If the point is q and has no symbol and I am clicking/hovering over it, figure out what symbol to put above it:
else if ((pval[exprnum][gridnumber - 1] != -1) && (qvals[exprnum][gridnumber - 1].includes(index))){
							var smallxindex = "smallx " + exprnum + "," + gridnumber + "," + index.split(',')[2];
							var smallcheckindex = "smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2];
							//If that q does work for that p, place a little //checkmark over that q
							
							var q0 = index.split(',')[2]
							var q1 = index.split(',')[3];
							var q2 = document.getElementById(index).style.fill;
							var q3 = index.split(',')[4];
							pointq[exprnum][gridnumber-1] = [q0,q1,q2,q3]
							getpqTruthVals(pointp,pointq,exprnum,gridnumber)
							if(exprEval(pointp,pointq,exprnum,gridnumber)){
								if (!(shownSymbols[exprnum][gridnumber - 1].includes("smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2]))){
									numqchecks[exprnum][gridnumber - 1] += 1
									shownSymbols[exprnum][gridnumber - 1].push(smallcheckindex)
									document.getElementById(smallcheckindex).style.visibility = "visible"
									
									}
								
								
								//var suffix = index.split(',')[0] + "," + index.split(',')[1]
								
	
								//	Additionally if that was the final q to check and none work, put a big Check over p.
								if((numqchecks[exprnum][gridnumber - 1] == numOfPoints) && (["2","3","4","7","8"].includes(exprnum))){
									finalCheck(shownSymbols,gridnumber,hiddenShownSymbols,numchecks,exprnum)
									//document.getElementById("bigcheckmark " + gridnumber).style.visibility = "visible";
								}
								if(["0","1","5","6","9"].includes(exprnum)){
									finalCheck(shownSymbols,gridnumber,hiddenShownSymbols,numchecks,exprnum)
									//document.getElementById("bigcheckmark " + gridnumber).style.visibility = "visible";
								}

							}
							//If that q doesn't work for that p, place a little X over that q
							else{
								//suffix = index.split(',')[0] + "," + index.split(',')[1]
								if (!(shownSymbols[exprnum][gridnumber - 1].includes("smallx " + exprnum + "," + gridnumber + "," + index.split(',')[2]))){
									numqxs[exprnum][gridnumber - 1] += 1
									document.getElementById(smallxindex).style.visibility = "visible"
									shownSymbols[exprnum][gridnumber - 1].push(smallxindex)
								}
												
		
								//	Additionally if that was the final q to check and none work, put a big X over p.
								//TO DO: make this not hard coded for 6 points
								if((numqxs[exprnum][gridnumber - 1] == numOfPoints) && (["0","1","5","6","9"].includes(exprnum))){
									finalX(shownSymbols,gridnumber,hiddenShownSymbols,numxs,exprnum)
								}
								if(["2","3","4","7","8"].includes(exprnum)){
									finalX(shownSymbols,gridnumber,hiddenShownSymbols,numxs,exprnum)
								}
														}
		
	}

	//there exists ...
	if (["0","1","2","3","4","8"].includes(exprnum) && (numchecks[exprnum][gridnumber - 1] > 0)){
		document.getElementById("bigcheckmark " + exprnum + "," + gridnumber).style.visibility = "visible";
	}
	//there exists ...
else if (["0","1","2","3","4","8"].includes(exprnum) && (numxs[exprnum][gridnumber - 1] == numOfPoints)){
	document.getElementById("bigx " + exprnum + "," + gridnumber).style.visibility = "visible";
	}

//for all ...
else if (["5","6","7","9"].includes(exprnum) && (numxs[exprnum][gridnumber - 1] > 0)){
	document.getElementById("bigx " + exprnum + "," + gridnumber).style.visibility = "visible";
	}
//for all ...
else if (["5","6","7","9"].includes(exprnum) && (numchecks[exprnum][gridnumber - 1] == numOfPoints)){
	document.getElementById("bigcheckmark " + exprnum + "," + gridnumber).style.visibility = "visible";
	}
}

function finalX(shownSymbols,gn,hiddenShownSymbols,numxs,exprnum){

if(shownSymbols[exprnum][gn-1][0].slice(0,5) == "place"){
document.getElementById(shownSymbols[exprnum][gn-1][0]).style.visibility = "hidden";
//shownSymbols[exprnum][gn-1][0] = "x " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2];
}


if (!(hiddenShownSymbols[exprnum][gn - 1].includes("x " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2]))){
			hiddenShownSymbols[exprnum][gn - 1].push("x " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2])
			numxs[exprnum][gn - 1] += 1
		}


document.getElementById("x " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2]).style.visibility = "visible";
}

function finalCheck(shownSymbols,gn,hiddenShownSymbols,numchecks,exprnum){


if(shownSymbols[exprnum][gn-1][0].slice(0,5) == "place"){
document.getElementById(shownSymbols[exprnum][gn-1][0]).style.visibility = "hidden";
}

if (!(hiddenShownSymbols[exprnum][gn - 1].includes("checkmark " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2]))){
			hiddenShownSymbols[exprnum][gn - 1].push("checkmark " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2])
			numchecks[exprnum][gn - 1] += 1
		}

document.getElementById("checkmark " + exprnum + "," + gn + "," + pval[exprnum][gn-1].split(',')[2]).style.visibility = "visible";

}

//I have hard coded this for the ten expressions in the midterm from spring 2023
function vacTrue(pointp,exprnum,gridnumber){
	if(exprnum == 0){
		return false
	}
else if (exprnum == 1){
		return (pointp[exprnum][gridnumber - 1][3] != "d")
		}
else if (exprnum == 2){
		return false
		}
else if (exprnum == 3){
		return (pointp[exprnum][gridnumber - 1][3] != "d")
		}
else if (exprnum == 4){
		return false
		}
else if (exprnum == 5){
		return (pointp[exprnum][gridnumber - 1][3] != "d")
		}
else if (exprnum == 6){
		return (pointp[exprnum][gridnumber - 1][3] != "d")
		}
else if (exprnum == 7){
		return (pointp[exprnum][gridnumber - 1][3] != "d")
		}
else if (exprnum == 8){
		return false
		}
else if (exprnum == 9){
		return false
		}
else{
alert("if you see this, something has gone wrong.")
return true
}
}

function vacFalse(pointp,exprnum,gridnumber){
	if(exprnum == 0){
		return pointp[exprnum][gridnumber - 1][3] != "d"
	}
else if (exprnum == 1){		
		return false
		}
else if (exprnum == 2){	
		return pointp[exprnum][gridnumber - 1][3] != "d"
		}
else if (exprnum == 3){
		return false
		}
else if (exprnum == 4){
		return pointp[exprnum][gridnumber - 1][3] != "d"
		}
else if (exprnum == 5){
		return false
		}
else if (exprnum == 6){	
		return false
		}
else if (exprnum == 7){
		return false
		}
else if (exprnum == 8){
		return false
		}
else if (exprnum == 9){
		return false
		}
else{
alert("if you see this, something has gone wrong.")
return true
}
}

//pointp = [x,y,color,shape]
//pointq = [x,y,color,shape]
function exprEval(pointp,pointq,exprnum,gridnumber){
if (exprnum == 0){
return (pointp[exprnum][gridnumber - 1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black") && Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])
}else if (exprnum == 1){
		return implies(pointp[exprnum][gridnumber - 1][3] == "d",implies(pointq[exprnum][gridnumber - 1][2] == "black",Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])))
		}
else if (exprnum == 2){
		return (pointp[exprnum][gridnumber - 1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black") && Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])
		}
else if (exprnum == 3){
		return implies((pointp[exprnum][gridnumber - 1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"),  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))
		}
else if (exprnum == 4){
		return (pointp[exprnum][gridnumber - 1][3] == "d") && implies((pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))
		}
else if (exprnum == 5){
		return implies((pointp[exprnum][gridnumber - 1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))
		}
else if (exprnum == 6){	
		return implies((pointp[exprnum][gridnumber - 1][3] == "d"), (pointq[exprnum][gridnumber - 1][2] == "black") && Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))
		}
else if (exprnum == 7){
		return implies((pointp[exprnum][gridnumber - 1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))
		}
else if (exprnum == 8){
		return implies((pointq[exprnum][gridnumber - 1][3] == "d"), (pointp[exprnum][gridnumber - 1][2] == "black") && Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1]))
		}
else if (exprnum == 9){
		return (pointq[exprnum][gridnumber - 1][3] == "d") && implies((pointp[exprnum][gridnumber - 1][2] == "black"), Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1]))
		}
else{
alert("if you see this, something has gone wrong.")
return true
}
}

window.clearTruthVals = function(event){
	var exprnum = event.target.parentElement.parentElement.parentElement.id;
	var index = event.target.getAttributeNS(null,"id");
	var gridnumber = index.split(',')[1];
	const elem = document.getElementById(index);


	var checkAbovep = "smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2];
	var xAbovep = "smallx " + exprnum + "," + gridnumber + "," + index.split(',')[2];
	if((pval[exprnum][gridnumber - 1] == index) && (event.type == "click") && !(shownSymbols[exprnum][gridnumber - 1].includes(checkAbovep) || shownSymbols[exprnum][gridnumber - 1].includes(xAbovep))){

	}
else{
	clearpqTruthVals(exprnum,gridnumber)
}

}

function clearTruthValsHelper(exprnum,gridnumber){
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";

	//clear little truth vals
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
}
function clearEveryTruthVal(exprnum,gridnumber){
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";

	//clear little truth vals
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
}

function clearpqTruthVals(exprnum,gridnumber){
	
if (!(["0","1","2","3","4","5","6","7"].includes(exprnum))){
document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
}


if (!(["8","9"].includes(exprnum))){
document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
}

	document.getElementById(true + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";
	document.getElementById(false + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "hidden";

	//clear little truth vals
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little true " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 1).style.visibility = "hidden";
	document.getElementById("little false " + exprnum + "," + gridnumber + "," + 2).style.visibility = "hidden";
}
function getpqTruthVals(pointp,pointq,exprnum,gridnumber){

clearpqTruthVals(exprnum,gridnumber)

if (["0","1","2","3","4","5","6","7"].includes(exprnum)){
var bigTruthVals = [pointp[exprnum][gridnumber-1][3] == "d", pointq[exprnum][gridnumber - 1][2] == "black", Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])]

}
else if (["8","9"].includes(exprnum)){
var bigTruthVals = [pointq[exprnum][gridnumber-1][3] == "d", pointp[exprnum][gridnumber - 1][2] == "black", Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1])]
}
else{
alert("THIS RIGHT HERE IS BAD")
}

document.getElementById(bigTruthVals[0] + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "visible";
document.getElementById(bigTruthVals[1] + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "visible";
document.getElementById(bigTruthVals[2] + " " + exprnum + "," + gridnumber + "," + 3).style.visibility = "visible";



setSmallTruthVals(pointp,pointq,exprnum,gridnumber)
}

function setSmallTruthVals(pointp,pointq,exprnum,gridnumber){
if (["0","2"].includes(exprnum)){
var smallTruthVals = [(pointp[exprnum][gridnumber-1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"),(pointq[exprnum][gridnumber - 1][2] == "black") &&  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])]

}
else if (["1"].includes(exprnum)){
var smallTruthVals = [implies((pointp[exprnum][gridnumber-1][3] == "d"), implies((pointq[exprnum][gridnumber - 1][2] == "black"),  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))),implies((pointq[exprnum][gridnumber - 1][2] == "black"),  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))]
}
else if (["3","5","7"].includes(exprnum)){
var smallTruthVals = [(pointp[exprnum][gridnumber-1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"), implies((pointp[exprnum][gridnumber-1][3] == "d") && (pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))]

}
else if (["4"].includes(exprnum)){
var smallTruthVals = [(pointp[exprnum][gridnumber-1][3] == "d") && implies((pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])), implies((pointq[exprnum][gridnumber - 1][2] == "black"), Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1]))]
}
else if (["9"].includes(exprnum)){
var smallTruthVals = [(pointq[exprnum][gridnumber-1][3] == "d") && implies((pointp[exprnum][gridnumber - 1][2] == "black"), Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1])), implies((pointp[exprnum][gridnumber - 1][2] == "black"), Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1]))]
}
else if (["6"].includes(exprnum)){
var smallTruthVals = [implies((pointp[exprnum][gridnumber-1][3] == "d"),(pointq[exprnum][gridnumber - 1][2] == "black") &&  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])),(pointq[exprnum][gridnumber - 1][2] == "black") &&  Dom(pointp[exprnum][gridnumber - 1],pointq[exprnum][gridnumber - 1])]
}
else if (["8"].includes(exprnum)){
var smallTruthVals = [implies((pointq[exprnum][gridnumber-1][3] == "d"),(pointp[exprnum][gridnumber - 1][2] == "black") &&  Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1])),(pointp[exprnum][gridnumber - 1][2] == "black") &&  Dom(pointq[exprnum][gridnumber - 1],pointp[exprnum][gridnumber - 1])]
}
else{
alert("THIS IS BAD")
}
document.getElementById("little " + smallTruthVals[0] + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "visible";
document.getElementById("little " + smallTruthVals[1] + " " + exprnum + "," + gridnumber + "," + 2).style.visibility = "visible";
return
}


function setFirstQuantifierTruthVals(pointp,pointq,exprnum,gridnumber){
if (["0","1","2","3","4","6","7"].includes(exprnum)){
var pTruthVals = [(pointp[exprnum][gridnumber-1][3] == "d")]
}
else if (["8","9"].includes(exprnum)){
var pTruthVals = [(pointp[exprnum][gridnumber-1][2] == "black")]
}
document.getElementById(pTruthVals[0] + " " + exprnum + "," + gridnumber + "," + 1).style.visibility = "visible";
return
}
function implies(bool1,bool2){
return ((!(bool1)) || bool2)
}
function removeAllSymbols(shownSymbols,gridnum1,exprnum){
shownSymbols[exprnum][gridnum1].forEach(elementID => document.getElementById(elementID).style.visibility = "hidden");
shownSymbols[exprnum][gridnum1] = []
}

function Dom(a,b){
return (parseInt(a[0]) > parseInt(b[0])) && (parseInt(a[1]) > parseInt(b[1]))
}

function getPsQs(event){
		var exprnum = event.target.parentElement.parentElement.parentElement.id;
		var index = event.target.getAttributeNS(null,"id");
		const elem = document.getElementById(index);
		var gridnumber = index.split(',')[1];
		if ((!(pchosen[exprnum][gridnumber - 1])) && (event.type == "click")){
				pchosen[exprnum][gridnumber - 1] = true
				pval[exprnum][gridnumber - 1] = index
				
				var p0 = index.split(',')[2]
				var p1 = index.split(',')[3];
				var p2 = document.getElementById(index).style.fill;
				var p3 = index.split(',')[4];
				pointp[exprnum][gridnumber-1] = [p0,p1,p2,p3]
		}
		else{
			var checkAbovep = "smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2];
			var xAbovep = "smallx " + exprnum + "," + gridnumber + "," + index.split(',')[2];
			if((pval[exprnum][gridnumber - 1] == index) && (event.type == "click") && (shownSymbols[exprnum][gridnumber - 1].includes(checkAbovep) || shownSymbols[exprnum][gridnumber - 1].includes(xAbovep))){
				pchosen[exprnum][gridnumber - 1] = false
				pval[exprnum][gridnumber - 1] = -1
				qvals[exprnum][gridnumber - 1] = []
			}
			else{
					if(!(qvals[exprnum][gridnumber - 1].includes(index))){
							qvals[exprnum][gridnumber - 1].push(index)
}else{
removeItemOnce(qvals[exprnum][gridnumber - 1],index)
}
}
	}
}

//function i copied from stack exchange
function removeItemOnce(arr, value) {
  var index = arr.indexOf(value);
  if (index > -1) {
    arr.splice(index, 1);
  }
  return arr;
}
     </script>
"""


# ╔═╡ 592b0ca4-213b-41ab-8edf-1569ddd62ae8
begin
	data1 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","o","o","o","o","d","o"],:fcolor=>["white","white","white","white","white","white","skyblue","pink"])
	data2 = Dict(:y=>[1,4,6,0,3,7],:marker=>["d","d","d","d","d","d"],:fcolor=>["black","black","white","black","black","black"])
	data3 = Dict(:y=>[1,4,6,0,3,7],:marker=>["d","d","o","d","d","o"],:fcolor=>["black","black","black","black","black","black"])
	data4 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","d","d","o","d"],:fcolor=>["white","white","white","white","white","white"])
	data5 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","d","d","o","d"],:fcolor=>["white","black","white","black","white","white"])
	data = [data1,data2,data3,data4,data5]
end

# ╔═╡ 3e3c456e-8c13-4a0f-bf9c-e77de553d526
function findNextMult3(n)
	return n + (3 - mod(n,3)) + 3
end

# ╔═╡ bf80d570-db90-4e25-837e-53df9f069b74
function plotGrid(width,height,shapeWidth,xbuffer,ybuffer,xShapes,yShapes,upperBuffer,xspaceBefore,xspaceAfter,yspaceBefore,yspaceAfter,xrange,yrange)
	letterHeight = 4.25
	letterWidth= 4
	maxHorVal = Int(findNextMult3(yShapes)/3)
	horizontalLines = []
	if (mod(yShapes,3) != 0) 
		maxHorVal = maxHorVal + 1
	end
	for i in 1:maxHorVal
	append!(horizontalLines,[@htl("""<text x="$(xbuffer - 4*letterWidth)" y="$(height - ybuffer - yspaceAfter + letterHeight - shapeWidth*3(i-1))">$(3*(i - 1)) </text>""")])
	append!(horizontalLines,[@htl("""<line x1="$xbuffer" y1="$(height - ybuffer - yspaceAfter - shapeWidth*3(i-1))" x2="$(width - xbuffer)" y2="$(height - ybuffer - yspaceAfter - shapeWidth*3(i-1))" stroke="gray" />""")])
	end

	verticalLines = []
	maxVertVal = Int(findNextMult3(xShapes)/3)-1
	if (mod(xShapes,3) != 0) 
		maxVertVal = maxVertVal + 1
	end
	for i in 1:maxVertVal
		append!(verticalLines,[@htl("""<text x="$(xbuffer + xspaceBefore - letterWidth  + 3(i-1)*shapeWidth)" y="$(height - ybuffer + 2 + 2*letterHeight )">$(3*(i-1))</text>""")])
		append!(verticalLines,[@htl("""<line x1="$(xbuffer + xspaceBefore + 3*(i-1)*shapeWidth)" y1="$upperBuffer" x2="$(xbuffer + xspaceBefore + 3*(i-1)*shapeWidth)" y2="$(height - ybuffer)" stroke="gray" />""")])
	end
	grid = @htl("""
    <rect x=$(xbuffer) y = $(upperBuffer) width=$(xspaceBefore + xrange + xspaceAfter) height=$(yspaceBefore + yrange + yspaceAfter) fill="white" stroke="black" /> 
	$([a for a in horizontalLines])
	$([a for a in verticalLines])


	""")

	return grid
end

# ╔═╡ 754cabb4-3f9b-46b5-ace2-095bb5ebc7ff
function genLatexQuantsHTML(exprnum,width,upperBuffer)
	thereExistsp = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
					  <msub>
					    <mrow class="MJX-TeXAtom-ORD">
					      <mo>&#x2203;</mo>
					    </mrow>
					    <mrow class="MJX-TeXAtom-ORD">
					      <mi>p</mi>
					    </mrow>
					  </msub>
					</math>
					  """
	thereExistsq = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
					  <msub>
					    <mrow class="MJX-TeXAtom-ORD">
					      <mo>&#x2203;</mo>
					    </mrow>
					    <mrow class="MJX-TeXAtom-ORD">
					      <mi>q</mi>
					    </mrow>
					  </msub>
					</math>
					  """
	forallp = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
  <msub>
    <mrow class="MJX-TeXAtom-ORD">
      <mo>&#x2200;</mo>
    </mrow>
    <mrow class="MJX-TeXAtom-ORD">
      <mi>p</mi>
    </mrow>
  </msub>
</math>
  """
	forallq = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
  <msub>
    <mrow class="MJX-TeXAtom-ORD">
      <mo>&#x2200;</mo>
    </mrow>
    <mrow class="MJX-TeXAtom-ORD">
      <mi>q</mi>
    </mrow>
  </msub>
</math>
  """
if (exprnum in [0,1,2,3,4])
	answer1 = thereExistsp
elseif (exprnum in [5,6,7])
	answer1 = forallp
elseif (exprnum in [8])
	answer1 = thereExistsq
elseif (exprnum in [9])
	answer1 = forallq
end


if (exprnum in [9])
	answer2 = thereExistsp
elseif (exprnum in [8])
	answer2 = forallp
elseif (exprnum in [0,1,5,6])
	answer2 = thereExistsq
elseif (exprnum in [2,3,4,7])
	answer2 = forallq
end
	equationOffset = 42
  return  @htl("""<foreignObject x="$(equationOffset - 13)" y="$(upperBuffer - 90)" width="$(162)" height="$((2/3)*upperBuffer - 9)">
    <div>
  $(answer1)
    </div>
  </foreignObject>
  <foreignObject x="$(equationOffset)" y="$(upperBuffer - 70)" width="$(162)" height="$((2/3)*upperBuffer - 9)">
    <div>
  $(answer2)
    </div>
  </foreignObject>""")
	  end

# ╔═╡ 4532e015-f2ba-4ee7-9044-22c7cda50204
function genLatexEqnHTML(exprnum,width,upperBuffer)
	if (exprnum in [0,2])
		answer = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>	
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
	  <mi>d</mi>
	  <mo stretchy="false">(</mo>
	  <mi>p</mi>
	  <mo stretchy="false">)</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
	  <mo>&#x2227;</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
	  <mi>b</mi>
	  <mo stretchy="false">(</mo>
	  <mi>q</mi>
	  <mo stretchy="false">)</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
	  <mo>&#x2227;</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
	  <mi>D</mi>
	  <mo stretchy="false">(</mo>
	  <mi>p</mi>
	  <mo>,</mo>
	  <mi>q</mi>
	  <mo stretchy="false">)</mo>
	</math>"""
	elseif (exprnum == 1)
		answer = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
 		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>	
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mi>d</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">&#x2192;</mo>
  <mo stretchy="false">(</mo>
  <mi>b</mi>
  <mo stretchy="false">(</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">&#x2192;</mo>
  <mi>D</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo>,</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">)</mo>
</math>"""
	elseif (exprnum in [3,5,7])
		answer = htl"""
		<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
				<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mo stretchy="false">(</mo>
  <mi>d</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo stretchy="false">)</mo>
  <mo>&#x2227;</mo>
  <mi>b</mi>
  <mo stretchy="false">(</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">&#x2192;</mo>
  <mi>D</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo>,</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
</math>"""
	elseif (exprnum in [4,9])
		answer = htl"""<math class="mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
  <mtext>&#xA0;</mtext>
  <mtext>&#xA0;</mtext>
  <mtext>&#xA0;</mtext>
  <mtext>&#xA0;</mtext>
  <mi>d</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo stretchy="false">)</mo>
  <mo>&#x2227;</mo>
  <mo stretchy="false">(</mo>
  <mi>b</mi>
  <mo stretchy="false">(</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mo stretchy="false">&#x2192;</mo>
		<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mi>D</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo>,</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">)</mo>
</math>"""
	elseif (exprnum in [6,8])
	answer = htl"""<math class = "mathsize" xmlns="http://www.w3.org/1998/Math/MathML">
   <mtext>&#xA0;</mtext>
	<mtext>&#xA0;</mtext>
	 <mtext>&#xA0;</mtext>
  <mtext>&#xA0;</mtext>
  <mi>d</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">&#x2192;</mo>
  <mo stretchy="false">(</mo>
  <mi>b</mi>
  <mo stretchy="false">(</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
	<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mo>&#x2227;</mo>
	<mtext>&#xA0;</mtext>
		<mtext>&#xA0;</mtext>
  <mi>D</mi>
  <mo stretchy="false">(</mo>
  <mi>p</mi>
  <mo>,</mo>
  <mi>q</mi>
  <mo stretchy="false">)</mo>
  <mo stretchy="false">)</mo>
</math>"""
	else
		answer = htl"""placeholder until I generalize"""
	end
	equationOffset = 42
  return  @htl("""<foreignObject x="$(equationOffset)" y="$(upperBuffer - 50)" width="$(180)" height="$((2/3)*upperBuffer - 9)">
    <div>
  $(answer)
    </div>
  </foreignObject>""")
	  end

# ╔═╡ 2fff0e1c-0902-48ab-84b5-bb84616f6451
function plotBigChecksX(data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter,upperBuffer)
	marks = []
	cx = width/2
	cy = shapeWidth
	scale=1
	bigCheck = @htl("""<polygon id="bigcheckmark $exprnum,$gridnumber" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

	bigX = @htl("""<polygon  id="bigx $exprnum,$gridnumber" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

	append!(marks,[bigCheck])
	append!(marks,[bigX])
	return marks
end

# ╔═╡ eddeeed3-8cba-4e46-a066-29685d979761
function plotCheckOrXBetter(i,data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)
			marks = []
			cx = xbuffer + xspaceBefore - shapeWidth/2 + shapeWidth*(i - 1)
			cy = height - ybuffer - yspaceAfter - shapeWidth*(data[:y][i])
			scale = .8
			placeholder = @htl("""<circle  id="placeholder $exprnum,$gridnumber,$(i-1)" cx=$(cx) cy=$(cy) r=5 style=" visibility:hidden; fill: cyan; stroke:cyan; stroke-width:0"/>""")


			check = @htl("""<polygon id="checkmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")
		

			x = @htl("""<polygon  id="x $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

			cx = cx + shapeWidth
			scale = .5
			smallCheck = @htl("""<polygon id="smallcheckmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)" style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

			smallx = @htl("""<polygon id="smallx $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

		
			append!(marks,[check])
			append!(marks,[smallCheck])
			append!(marks,[x])
			append!(marks,[smallx])
			append!(marks,[placeholder])
			return @htl("""$([mark for mark in marks])""")
end

# ╔═╡ 622041f3-382c-4778-821d-faff0e328df6
function plotPointBetter(i,data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)
			cx = xbuffer + xspaceBefore + shapeWidth*(i - 1)
			cy = height - ybuffer - yspaceAfter - shapeWidth*(data[:y][i])
			shape = data[:marker][i]
			color = data[:fcolor][i]

			if shape == "d"
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),d" points="$(cx) $(cy-15),$(cx+10) $(cy),$(cx) $(cy+15),$(cx-10) $(cy)" onmouseout = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill: $(color); stroke:black; stroke-width:2"/>""")
			elseif shape == "o"
				dot = @htl("""<circle id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),o" cx=$(cx) cy=$(cy) r=10 onmouseleave = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2"/>""")	
			elseif (shape == "x") || (shape == "X")
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),X" points="$(cx) $(cy-5),$(cx+5) $(cy-10),$(cx+10) $(cy-5),$(cx+5) $(cy),$(cx+10) $(cy+5),$(cx+5) $(cy+10),$(cx) $(cy+5),$(cx-5) $(cy+10),$(cx-10) $(cy+5),$(cx-5) $(cy),$(cx-10) $(cy-5),$(cx-5) $(cy-10)" onmouseleave = clearTruthVals(event) onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2"/>""")
			else
				dot = "error"
				@assert(false)
			end
			checkOrX = plotCheckOrXBetter(i,data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)

			
			return @htl("""<svg>$(dot)$(checkOrX)</svg>""")
end

# ╔═╡ 63f917d5-3872-4c56-b48a-12e099ea2dc4
##For a given grid, plots all points, checks, xs, dominating lines, and truth values
function plotPointsBetter(data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)
	dots = []
	for i in 1:size(data[:y])[1]
			fullAnswer = plotPointBetter(i,data,gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)
			append!(dots,[fullAnswer])
	end
	return dots
end

# ╔═╡ e1b9d106-0c86-4530-9a13-d5d01502026e
function genHTML(data,exprnum)
	ans = []
	for gridNumberPlus1 in 1:size(data)[1]
		##x buffer is how many pixels are to the left of the grid in the grid svg
		##x buffer is also how many pixels are to the right of the grid in the grid svg
		xbuffer = 40
		##y buffer is how many pixels are below the grid in the grid svg
		ybuffer = 40	
		##upperBuffer is how many pixels are above the grid in the grid svg
		upperBuffer = 100
		##shape width is approximately how wide the average shape is
		shapeWidth = 20
		##yspaceBefore is the distance between the top edge of the grid and the top horizontal line inside the grid
		yspaceBefore = 0
		##yspaceBefore is the distance between the bottom edge of the grid and the bottom horizontal line inside the grid
		yspaceAfter = shapeWidth
		##xspaceBefore is the distance between the left edge of the grid and the leftmost vertical line inside the grid
		xspaceBefore = shapeWidth
		##xspaceAfter is the distance between the right edge of the grid and the rightmost vertical line inside the grid
		xspaceAfter = shapeWidth
		##maxx is the biggest x value that we have in our data
		maxx = size(data[gridNumberPlus1][:y])[1] - 1

		##theoretecally adding invisible data points that don't do anything except pad the number of vertical lines inside the grid. Looks nicer with the extra space like this
		if (mod(maxx,3) == 0)
			extraXshapes = mod(maxx,3)
		else
			extraXshapes = 3-mod(maxx,3)
		end
		##xrange is the distance from the leftmost vertical line inside the grid to the rightmost vertical line inside the grid
		xrange = (maxx + extraXshapes)*(shapeWidth)
		
		##maxy is the biggest y value that we have in our data
		maxy = maximum(data[gridNumberPlus1][:y])

		##theoretecally adding invisible data points that don't do anything except pad the number of horizontal lines inside the grid. Looks nicer with the extra space like this
		if (mod(maxy,3) == 0)
			extraYshapes = 3-mod(maxy,3)
		else
			extraYshapes = 3*2-mod(maxy,3)
		end
		##yrange is the distance from the topmost horizontal line inside the grid to the bottommost horizontal line inside the grid
		yrange = (maxy + extraYshapes)*shapeWidth
		
		##width of a grid
		##explanation: the whole width is the space before the grid (xbuffer) plus the white space inside the grid but before the first vertical line (xspaceBefore) plus the width needed to fit all the shapes (xrange) plus the white space after the last vertical line and before the edge (xspaceAfter) plus the space after the grid (xbuffer)
		width = xbuffer + xspaceBefore + xrange + xspaceAfter + xbuffer
		##height of a grid
		##explanation: analagous to width
		height = upperBuffer + yspaceBefore + yrange + yspaceAfter + ybuffer

		##the svgs for the data points
		#bigDots = plotPoints(data[i],i,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)

		bigDots = plotPointsBetter(data[gridNumberPlus1],gridNumberPlus1,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter)
		##the svgs for the checks and x's corresponding to each data point, as well as the check and x above the grid
		#checksx = plotHiddenXsandChecks(data[gridnumberPlus1],gridnumber,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter,upperBuffer)
		checksx = plotBigChecksX(data[gridNumberPlus1],gridNumberPlus1,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter,upperBuffer)
		##the svgs for the big and little trues and falses above the grid
		TFs = plotHiddenTruthVals(data[gridNumberPlus1],gridNumberPlus1,exprnum,width,upperBuffer,xbuffer,xspaceBefore)
		##the svgs for the dominating lines corresponding to each data point
		dom = plotDominatingLines(data[gridNumberPlus1],gridNumberPlus1,exprnum,width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,xspaceBefore,yspaceAfter,upperBuffer)
		##the grid itself with axes and labels
		grid = plotGrid(width,height,shapeWidth,xbuffer,ybuffer,maxx,maxy,upperBuffer,xspaceBefore,xspaceAfter,yspaceBefore,yspaceAfter,xrange,yrange)

		latex = genLatexEqnHTML(exprnum,width,upperBuffer)
		latexQuants = genLatexQuantsHTML(exprnum,width,upperBuffer)
		##the svg putting everything for a single grid together
		temp = [@htl("""
		<svg width=$(width) height=$(height + upperBuffer) id = "exprnum $exprnum,numofPoints $(size(data[gridNumberPlus1][:y])[1])" >
			$(latexQuants)
			$(latex)
				$(grid)
				$([f for f in dom])
				$([f for f in bigDots])
				$([f for f in checksx])
				$([f for f in TFs])
				</svg>""")]
		append!(ans, temp)
	end
##all the svgs for all the grids for a given expression
return htl"""
<div id="$exprnum">
$([a for a in ans])
</div>
"""
	end

# ╔═╡ ebdf845c-ed6c-4e81-8daf-b546c2b76e75
htl"""
	$(genHTML(data,0))
	"""

# ╔═╡ efc174e1-9e24-4071-aa4d-1763be219128
htl"""
	$(genHTML(data,1))
	"""

# ╔═╡ 7041c49f-9d21-433c-b924-0bce56151ff6
htl"""
	$(genHTML(data,2))
	"""

# ╔═╡ c2ecefe9-f619-4633-8b0c-b414cf1b0f3e
htl"""
	$(genHTML(data,3))
	"""

# ╔═╡ 6dca7ba4-136d-4b15-b99c-36969817cf4c
htl"""
	$(genHTML(data,4))
	"""

# ╔═╡ ffc94ad9-1bfa-442b-857c-fda1a8d888a3
htl"""
	$(genHTML(data,5))
	"""

# ╔═╡ 356cc4ad-efe4-4476-810e-54f830738e65
htl"""
	$(genHTML(data,6))
	"""

# ╔═╡ a7281802-efb9-4d88-936b-a63175aae959
htl"""
	$(genHTML(data,7))
	"""

# ╔═╡ fa82b91c-64a5-4a8c-a59c-994c598d96ad
htl"""
	$(genHTML(data,8))
	"""

# ╔═╡ 1d65df6f-6ff2-4074-90fc-ce777a024d64
htl"""
	$(genHTML(data,9))
	"""

# ╔═╡ Cell order:
# ╟─62dbc6d2-eda7-4696-b7c6-f5a7f0e7b252
# ╟─7f2b3abb-074c-4c2c-9340-3363d6d265c7
# ╟─ebdf845c-ed6c-4e81-8daf-b546c2b76e75
# ╟─ce1b567a-e944-4dc6-a489-b811dc10de4e
# ╟─efc174e1-9e24-4071-aa4d-1763be219128
# ╟─1bfb38f3-dcaf-49a4-82a6-7fce6bfb8177
# ╟─7041c49f-9d21-433c-b924-0bce56151ff6
# ╟─4b9c9166-7a2a-4e49-81fe-88909778c621
# ╟─c2ecefe9-f619-4633-8b0c-b414cf1b0f3e
# ╟─cdcbf0ff-6dec-412a-a5dd-999dab5d4965
# ╟─6dca7ba4-136d-4b15-b99c-36969817cf4c
# ╟─938dd6cf-1ed0-44a8-a73a-f911788e200c
# ╟─ffc94ad9-1bfa-442b-857c-fda1a8d888a3
# ╟─5981046a-84dd-426a-8fdd-550784364aff
# ╟─356cc4ad-efe4-4476-810e-54f830738e65
# ╟─5fbbd8b2-28d8-4cee-8380-4bb274fd55cf
# ╟─a7281802-efb9-4d88-936b-a63175aae959
# ╟─2a74a4e8-9355-4d20-b41b-536765aeeba1
# ╟─fa82b91c-64a5-4a8c-a59c-994c598d96ad
# ╟─5d1f0be1-844f-4cef-bdbd-c343af4116bd
# ╟─1d65df6f-6ff2-4074-90fc-ce777a024d64
# ╠═04efa7a2-f585-422b-96c5-0c11ceec3886
# ╟─aa4a54a2-89e2-4265-b81a-779bb36fc08a
# ╟─b4df5d67-1184-40b2-8557-64e39f3a59ac
# ╟─6021134f-f508-4c9b-ba84-e048ba6a5cba
# ╟─e6726386-5c9d-4f08-9ec9-e78fa108e39b
# ╟─3f52af75-c390-4423-9b52-a52c81791c92
# ╟─bf80d570-db90-4e25-837e-53df9f069b74
# ╟─0606bc8c-5132-4b17-8348-2b0358650041
# ╟─592b0ca4-213b-41ab-8edf-1569ddd62ae8
# ╟─3e3c456e-8c13-4a0f-bf9c-e77de553d526
# ╟─e1b9d106-0c86-4530-9a13-d5d01502026e
# ╟─754cabb4-3f9b-46b5-ace2-095bb5ebc7ff
# ╟─4532e015-f2ba-4ee7-9044-22c7cda50204
# ╟─63f917d5-3872-4c56-b48a-12e099ea2dc4
# ╟─2fff0e1c-0902-48ab-84b5-bb84616f6451
# ╟─622041f3-382c-4778-821d-faff0e328df6
# ╟─eddeeed3-8cba-4e46-a066-29685d979761
