--[[
	Conway's Game of Life Simple Version
	Zhou Jia	
	February 17, 2014
	References: www.fullycroisened.com, 

--]]

local unit =10  --the side length of a cell

--a function to build a matrix with all cells containing 0
function buildMatrix(width, height)
	local t={}
	for i=1, height do
		t[i]={}
		for j=1,width do
			t[i][j]=0
		end
	end
	return t
end

--a function to build a matrix with cells containing either 1 or 0
function randomMatrix(width, height)
	local t={}
	for i=1, height do
		t[i]={} 
		--I am creating this table with the table "t"
		--so that I can manipulate it like a proper array
		--sort of......
		--it is like 
		-- t={
		-- [1]={}
		-- [2]={}
		-- ...
		-- [i]={}
		-- }
		for j=1,width do
			t[i][j]=math.random(0,1)
		end
	end
	return t
end

local myTable=randomMatrix(30,30)

--insert a shape

--glider={0,1,0,0,0,1,1,1,1,3,3} --example

-- function insertShape(shape, left, top)
   -- for i=
-- end

--create a custom method for myTable
--display the matrix on the screen
function myTable:draw()
	local x, y =0, 0
	for i=1, #self  do  --self refers to myTable
		for j=1,#self[i] do
			local mySquare=display.newRect(x, y, unit, unit)
			--local mySquare=display.newCircle(x, y, unit)
			mySquare.x=100+j*unit
			mySquare.y=100+i*unit
			if self[i][j]==1 then
				mySquare:setFillColor(0,1,0) --green
				--print(mySquare.x)
			else
				mySquare:setFillColor(0,0,0)
			end				
		end
	end
end

--cells are going to evolve
function evolve(t)
	local temp=buildMatrix(#t,#t)  --a temporary matrix to store new values
	temp=t
	
	--border cells don't have 8 neightbours
	--it will be problematic when I calculate the sum of the 8 cells
	--so I want to create another temporary table 
	--which has two more columns and two more rows
	--"wrapping" the table I am dealing with
	--the temp2 is only for the purpose of calculating sum
	
	local temp2=buildMatrix(#t+2,#t+2) 
	for i=1, #t do
		for j=1,#t[i] do
			temp2[i+1][j+1]=t[i][j]
		end
	end
	--go through each cell and check its value
	for i=1, #t do
		for j=1,#t[i] do
			--sum up the eight cells neighbouring the center cell
			local sum=temp2[i][j]+temp2[i][j+1]+temp2[i][j+2]+
						temp2[i+1][j]+temp2[i+1][j+2]+
						temp2[i+2][j]+temp2[i+2][j+1]+temp2[i+2][j+2]
						--print (sum)
			--now it is time to apply the rules
			if t[i][j]== 0 then
				if sum == 3 then
					temp[i][j]=1
				else
					temp[i][j]=0
				end
			end
			if t[i][j]==1 then
				if sum<2 or sum>3 then
					temp[i][j]=0
				else
					temp[i][j]=1
				end
			end
		end
	end
	t=temp --overwrite t
	return t --now we have a brand new "t"
end


local function runConway( event )
	myTable:draw()
    myTable=evolve(myTable)
end

timer.performWithDelay( 100, runConway, 0)
