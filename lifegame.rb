class Lifegame
	def initialize(cells)
		@cells = cells
		@neighbors = [
			[1,3,4],
			[0,2,3,4,5],
			[1,4,5],
			[0,1,4,6,7],
			[0,1,2,3,5,6,7,8],
			[1,2,4,7,8],
			[3,4,7],
			[3,4,5,6,8],
			[4,5,7]
		]
	end

	def get_cell_status(cell_num)
		return convert(@cells[cell_num])
	end

	def convert(num)
		num == 1 ? "A" : "D"
	end
	private :convert

	def show
		cell_statuses = @cells.map {|cell| convert(cell)}
		matrix = []
		cell_statuses.each_slice(3) do |s|
			matrix << s
		end
		return matrix
	end

	def count_around_alive(cell_num)
		alive_count = 0
		@neighbors[cell_num].each do |neighbor|
			alive_count += 1 if @cells[neighbor] == 1
		end
		return alive_count
	end
	private :count_around_alive

	def is_alive?(cell_num)
		@cells[cell_num] == 1 ? true : false
	end

	def dead_or_alive(cell_num)
		alive_count = count_around_alive(cell_num)
		if is_alive?(cell_num)	# 対象セルが生きている
			if alive_count >= 4
				return 0
			elsif alive_count <= 1
				return 0
			else
				return 1
			end
		else					# 対象セルが死んでいる
			return alive_count == 3 ? 1 : 0
		end
	end

	def next
		return @cells.map!.with_index {|cell,index| dead_or_alive(index)}
	end
end