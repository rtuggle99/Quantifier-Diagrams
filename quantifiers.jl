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
</style>
"""

# ╔═╡ db720d97-9de9-47fa-9131-414f0e5cb3c0
function plotPoints(data,gridnumber,exprnum)
	dots = []
	for i in 1:size(data[:y])[1]
			cx = 40 + 20*(i - 1)
			cy = 40 + 20*(12 - data[:y][i])
			shape = data[:marker][i]
			color = data[:fcolor][i]
			#"""<td><button onclick="toggleColumn(this);">$(data.y)</button></td>"""

			if shape == "d"
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),d" points="$(cx) $(cy-15),$(cx+10) $(cy),$(cx) $(cy+15),$(cx-10) $(cy)" onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill: $(color); stroke:black; stroke-width:2"/>""")
			elseif shape == "o"
				dot = @htl("""<circle id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),o" cx=$(cx) cy=$(cy) r=10 onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2" />""")
			elseif (shape == "x") || (shape == "X")
				dot = @htl("""<polygon id="$exprnum,$gridnumber,$(i-1),$(data[:y][i]),X" points="$(cx) $(cy-5),$(cx+5) $(cy-10),$(cx+10) $(cy-5),$(cx+5) $(cy),$(cx+10) $(cy+5),$(cx+5) $(cy+10),$(cx) $(cy+5),$(cx-5) $(cy+10),$(cx-10) $(cy+5),$(cx-5) $(cy),$(cx-10) $(cy-5),$(cx-5) $(cy-10)" onMouseOver = putCheckorX(event) onClick = putCheckorX(event) style=" fill:$(color); stroke:black; stroke-width:2"/>""")
			else
				dot = "error"
				@assert(false)
			end
			append!(dots,[dot])
	end
	return dots
end

# ╔═╡ 24ec3ed2-9ac9-4a94-bb4e-d6c8fcc9a2be
function plotHiddenXsandChecks(data,gridnumber,exprnum)
	marks = []
	for i in 1:size(data[:y])[1]
			cx = 30 + 20*(i - 1)
			cy = 40 + 20*(12 - data[:y][i])
			scale = .8

			placeholder = @htl("""<circle  id="placeholder $exprnum,$gridnumber,$(i-1)" cx=$(cx) cy=$(cy) r=5 style=" visibility:hidden; fill: cyan; stroke:cyan; stroke-width:0"/>""")


			check = @htl("""<polygon id="checkmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")
		

			x = @htl("""<polygon  id="x $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

			cx = 50 + 20*(i - 1)
			scale = .5
			smallCheck = @htl("""<polygon id="smallcheckmark $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)" style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

			smallx = @htl("""<polygon id="smallx $exprnum,$gridnumber,$(i-1)" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

		
			append!(marks,[check])
			append!(marks,[smallCheck])
			append!(marks,[x])
			append!(marks,[smallx])
			append!(marks,[placeholder])
	end
	cx = 100
	cy = 20
	scale=1
	bigCheck = @htl("""<polygon id="bigcheckmark $exprnum,$gridnumber" points="$(cx) $(cy),$(cx-scale*5) $(cy-scale*5),$(cx-scale*10) $(cy),$(cx) $(cy+scale*10),$(cx+scale*15) $(cy-scale*15),$(cx+scale*10) $(cy-scale*20)"  style=" visibility:hidden; fill: lightgreen; stroke:green; stroke-width:1"/>""")

	bigX = @htl("""<polygon  id="bigx $exprnum,$gridnumber" points="$(cx) $(cy-scale*5),$(cx+scale*5) $(cy-scale*12),$(cx+scale*12) $(cy-scale*5),$(cx+scale*5) $(cy),$(cx+scale*12) $(cy+scale*5),$(cx+scale*5) $(cy+scale*12),$(cx) $(cy+scale*5),$(cx-scale*5) $(cy+scale*12),$(cx-scale*12) $(cy+scale*5),$(cx-scale*5) $(cy),$(cx-scale*12) $(cy-scale*5),$(cx-scale*5) $(cy-scale*12)" style=" visibility:hidden; fill: red; stroke:maroon; stroke-width:1"/>""")

	append!(marks,[bigCheck])
	append!(marks,[bigX])
	return marks
end

# ╔═╡ ce0e99ba-cfce-4070-84d3-1a7617d14720
function plotDominatingLines(data,gridnumber,height,exprnum)
	marks = []
	for i in 1:size(data[:y])[1]
			cx = 40 + 20*(i - 1)
			cy = 40 + 20*(12 - data[:y][i])
			normdom = @htl("""<polyline id="normalDom $exprnum,$gridnumber,$(i-1)" points="20,$(cy) $(cx),$(cy) $(cx),$(40 + height - 60)" style="visibility:hidden; fill:none; stroke:black; stroke-width:3" />""")
			invdom = @htl("""<polyline id="invDom $exprnum,$gridnumber,$(i-1)" points="180,$(cy) $(cx),$(cy) $(cx),40" style="visibility:hidden; fill:none; stroke:black; stroke-width:3" />""")
	
			append!(marks,[normdom])
			append!(marks,[invdom])
	end
	return marks
end

# ╔═╡ dbb5eea3-add5-46cc-957b-86a237101dc8
function plotGrid(width,height,shapeWidth,buffer)
	letterHeight = 4.25
	letterWidth = 4
	grid = @htl("""
    <rect x=$(shapeWidth) y = $(2*shapeWidth) width=$(width - 60) height=$(height - 60) fill="white" stroke="black" /> 
	<text x="0" y="$(buffer + letterHeight)">12 </text>
	<text x="5" y="$(buffer + shapeWidth*3 + letterHeight)">9 </text>
	<text x="5" y="$(buffer + shapeWidth*6 + letterHeight)">6 </text>
	<text x="5" y="$(buffer + shapeWidth*9 + letterHeight)">3 </text>
	<text x="5" y="$(buffer + shapeWidth*12 + letterHeight)">0 </text>
	<text x="$(buffer-letterWidth)" y="$(height + 2 + 2*letterHeight - 15)">0</text>
	<text x="$(buffer-letterWidth + 3*shapeWidth)" y="$(height + 2*letterHeight - 15)">3</text>
	<text x="$(buffer-letterWidth + 6*shapeWidth)" y="$(height + 2 + 2*letterHeight - 15)">6</text>



	<line x1="20" y1="$(buffer + shapeWidth*3)" x2="$(20 + width - 60)" y2="$(buffer + 20*3)" stroke="gray" />
	<line x1="20" y1="$(buffer + shapeWidth*6)" x2="$(20 + width - 60)" y2="$(buffer + 20*6)" stroke="gray" />
	<line x1="20" y1="$(buffer + shapeWidth*9)" x2="$(20 + width - 60)" y2="$(buffer + 20*9)" stroke="gray" />
	<line x1="20" y1="$(buffer + shapeWidth*12)" x2="$(20 + width - 60)" y2="$(buffer + 20*12)" stroke="gray" />


	<line x1="$(buffer)" y1="40" x2="$(buffer)" y2="$(40 + height - 60)" stroke="gray" />
	<line x1="$(buffer + 3*shapeWidth)" y1="40" x2="$(buffer + 3*shapeWidth)" y2="$(40 + height - 60)" stroke="gray" />
	<line x1="$(buffer + 6*shapeWidth)" y1="40" x2="$(buffer + 6*shapeWidth)" y2="$(40 + height - 60)" stroke="gray" />
	<line x1="40" y1="40" x2="40" y2="$(40 + height - 60)" stroke="gray" />
	""")

	return grid
end

# ╔═╡ 0606bc8c-5132-4b17-8348-2b0358650041
##this function makes the assumption that there are at most five grids
htl"""
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


//This function reveals an x or check over the point that was just clicked. It also puts a p or q on the shape to label it
//This function places a big or little check or x above the p or q that you click on.
window.putCheckorX = function(event)
{
	var exprnum = event.target.parentElement.parentElement.id;
	//get the p selected (if there is one) and all the qs that are currently selected (if there are any).  Use the variables pchosen and qvals.length to figure out if any are selected.
	getPsQs(event)
	
	//getting info about the point I clicked
	var index = event.target.getAttributeNS(null,"id");
	var gridnumber = index.split(',')[1];
	const elem = document.getElementById(index);

	
	//If the point is p and I have just unclicked it, hide the symbol that was above //it and hide the symbols that were above any q's.
	if(pchosen[exprnum][gridnumber - 1] == false){
		shownSymbols[exprnum][gridnumber - 1] = removeItemOnce(shownSymbols[exprnum][gridnumber - 1],index)
		removeAllSymbols(shownSymbols,gridnumber - 1,exprnum)
		numqchecks[exprnum][gridnumber-1] = 0
		numqxs[exprnum][gridnumber-1] = 0
	}

	//If the point is p and I have just clicked it, figure out what symbol to put above it:
	if((pval[exprnum][gridnumber - 1] == index) && (event.type == "click")){
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
		
	}
//If the point is q and has no symbol and I am hovering over it, figure out what symbol to put above it:
else if ((pval[exprnum][gridnumber - 1] != -1) && (event.type == "mouseover") && (qvals[exprnum][gridnumber - 1].includes(index))){
							var smallxindex = "smallx " + exprnum + "," + gridnumber + "," + index.split(',')[2];
							var smallcheckindex = "smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2];
							//If that q does work for that p, place a little //checkmark over that q
							
							var q0 = index.split(',')[2]
							var q1 = index.split(',')[3];
							var q2 = document.getElementById(index).style.fill;
							var q3 = index.split(',')[4];
							pointq[exprnum][gridnumber-1] = [q0,q1,q2,q3]
							if(exprEval(pointp,pointq,exprnum,gridnumber)){
								if (!(shownSymbols[exprnum][gridnumber - 1].includes("smallcheckmark " + exprnum + "," + gridnumber + "," + index.split(',')[2]))){
									numqchecks[exprnum][gridnumber - 1] += 1
									shownSymbols[exprnum][gridnumber - 1].push(smallcheckindex)
									document.getElementById(smallcheckindex).style.visibility = "visible"
									
									}
								
								
								//var suffix = index.split(',')[0] + "," + index.split(',')[1]
								
	
								//	Additionally if that was the final q to check and none work, put a big Check over p.
								//TO DO: make this not hard coded for 6 points
								if((numqchecks[exprnum][gridnumber - 1] == 6) && (["2","3","4","7","8"].includes(exprnum))){
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
								if((numqxs[exprnum][gridnumber - 1] == 6) && (["0","1","5","6","9"].includes(exprnum))){
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
else if (["0","1","2","3","4","8"].includes(exprnum) && (numxs[exprnum][gridnumber - 1] == 6)){
	document.getElementById("bigx " + exprnum + "," + gridnumber).style.visibility = "visible";
	}

//for all ...
else if (["5","6","7","9"].includes(exprnum) && (numxs[exprnum][gridnumber - 1] > 0)){
	document.getElementById("bigx " + exprnum + "," + gridnumber).style.visibility = "visible";
	}
//for all ...
else if (["5","6","7","9"].includes(exprnum) && (numchecks[exprnum][gridnumber - 1] == 6)){
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

function implies(bool1,bool2){
return ((!(bool1)) || bool2)
}
function removeAllSymbols(shownSymbols,gridnum1,exprnum){
shownSymbols[exprnum][gridnum1].forEach(elementID => document.getElementById(elementID).style.visibility = "hidden");
shownSymbols[exprnum][gridnum1] = []
}

function Dom(a,b){
return (a[0] > b[0]) && (a[1] > b[1])
}

function getPsQs(event){
		var exprnum = event.target.parentElement.parentElement.id;
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
			if((pval[exprnum][gridnumber - 1] == index) && (event.type == "click")){
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
	data1 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","o","o","o","o"],:fcolor=>["white","white","white","white","white","white"])
	data2 = Dict(:y=>[1,4,6,0,3,7],:marker=>["d","d","d","d","d","d"],:fcolor=>["black","black","white","black","black","black"])
	data3 = Dict(:y=>[1,4,6,0,3,7],:marker=>["d","d","o","d","d","o"],:fcolor=>["black","black","black","black","black","black"])
	data4 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","d","d","o","d"],:fcolor=>["white","white","white","white","white","white"])
	data5 = Dict(:y=>[1,4,6,0,3,7],:marker=>["o","o","d","d","o","d"],:fcolor=>["white","black","white","black","white","white"])
	data = [data1,data2,data3,data4,data5]
	buffer = 40
	shapeWidth = 20
	width = buffer + shapeWidth*7 + buffer
	height = buffer + shapeWidth * 12 + buffer
end

# ╔═╡ c54c9950-fd6a-4664-a046-1ac9764a4e0a
function genHTML(data,width,height,exprnum)
	exprnum = exprnum - 1
	data1 = data[1]
	data2 = data[2]
	data3 = data[3]
	data4 = data[4]
	data5 = data[5]
	
	bigDots1 = plotPoints(data1,1,exprnum)
	bigDots2 = plotPoints(data2,2,exprnum)
	bigDots3 = plotPoints(data3,3,exprnum)
	bigDots4 = plotPoints(data4,4,exprnum)
	bigDots5 = plotPoints(data5,5,exprnum)

	checksx1 = plotHiddenXsandChecks(data1,1,exprnum)
	checksx2 = plotHiddenXsandChecks(data2,2,exprnum)
	checksx3 = plotHiddenXsandChecks(data3,3,exprnum)
	checksx4 = plotHiddenXsandChecks(data4,4,exprnum)
	checksx5 = plotHiddenXsandChecks(data5,5,exprnum)

	dom1 = plotDominatingLines(data1,1,height,exprnum)
	dom2 = plotDominatingLines(data2,2,height,exprnum)
	dom3 = plotDominatingLines(data3,3,height,exprnum)
	dom4 = plotDominatingLines(data4,4,height,exprnum)
	dom5 = plotDominatingLines(data5,5,height,exprnum)
	
	grid1 = plotGrid(width,height,shapeWidth,buffer)
	grid2 = plotGrid(width,height,shapeWidth,buffer)
	grid3 = plotGrid(width,height,shapeWidth,buffer)
	grid4 = plotGrid(width,height,shapeWidth,buffer)
	grid5 = plotGrid(width,height,shapeWidth,buffer)
	return htl"""
<div id="$exprnum">
	<svg width=$(width) height=$(height)>
	$(grid1)
	$([f for f in dom1])
	$([f for f in bigDots1])
	$([f for f in checksx1])
	</svg>
	<svg width=$(width) height=$(height)>
	$(grid2)
	$([f for f in dom2])
	$([f for f in bigDots2])
	$([f for f in checksx2])
	</svg>
	<svg width=$(width) height=$(height)>
	$(grid3)
	$([f for f in dom3])
	$([f for f in bigDots3])
	$([f for f in checksx3])
	</svg>
	<svg width=$(width) height=$(height)>
	$(grid4)
	$([f for f in dom4])
	$([f for f in bigDots4])
	$([f for f in checksx4])
	</svg>
	<svg width=$(width) height=$(height)>
	$(grid5)
	$([f for f in dom5])
	$([f for f in bigDots5])
	$([f for f in checksx5])
	</svg>
		</div>
	"""
	end

# ╔═╡ ebdf845c-ed6c-4e81-8daf-b546c2b76e75
htl"""
	$(genHTML(data,width,height,1))
	"""

# ╔═╡ efc174e1-9e24-4071-aa4d-1763be219128
htl"""
	$(genHTML(data,width,height,2))
	"""

# ╔═╡ 7041c49f-9d21-433c-b924-0bce56151ff6
htl"""
	$(genHTML(data,width,height,3))
	"""

# ╔═╡ c2ecefe9-f619-4633-8b0c-b414cf1b0f3e
htl"""
	$(genHTML(data,width,height,4))
	"""

# ╔═╡ 6dca7ba4-136d-4b15-b99c-36969817cf4c
htl"""
	$(genHTML(data,width,height,5))
	"""

# ╔═╡ ffc94ad9-1bfa-442b-857c-fda1a8d888a3
htl"""
	$(genHTML(data,width,height,6))
	"""

# ╔═╡ 356cc4ad-efe4-4476-810e-54f830738e65
htl"""
	$(genHTML(data,width,height,7))
	"""

# ╔═╡ a7281802-efb9-4d88-936b-a63175aae959
htl"""
	$(genHTML(data,width,height,8))
	"""

# ╔═╡ fa82b91c-64a5-4a8c-a59c-994c598d96ad
htl"""
	$(genHTML(data,width,height,9))
	"""

# ╔═╡ 1d65df6f-6ff2-4074-90fc-ce777a024d64
htl"""
	$(genHTML(data,width,height,10))
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
# ╟─04efa7a2-f585-422b-96c5-0c11ceec3886
# ╟─aa4a54a2-89e2-4265-b81a-779bb36fc08a
# ╟─db720d97-9de9-47fa-9131-414f0e5cb3c0
# ╟─24ec3ed2-9ac9-4a94-bb4e-d6c8fcc9a2be
# ╟─ce0e99ba-cfce-4070-84d3-1a7617d14720
# ╟─dbb5eea3-add5-46cc-957b-86a237101dc8
# ╟─0606bc8c-5132-4b17-8348-2b0358650041
# ╟─592b0ca4-213b-41ab-8edf-1569ddd62ae8
# ╟─c54c9950-fd6a-4664-a046-1ac9764a4e0a
