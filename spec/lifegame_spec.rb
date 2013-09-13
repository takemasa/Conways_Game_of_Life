require "./lifegame"
describe Lifegame do
	it "セルが生きているときに、セルの状態を取得すると、Aが返ってくる" do
		lifegame = Lifegame.new([1,0,0,0,0,0,0,0,0])
		expect(lifegame.get_cell_status(0)).to eq("A")
	end
	it "セルが死んでいるときに、セルの状態を取得すると、Dが返ってくる" do
		lifegame = Lifegame.new([0,0,1,0,1,0,1,0,1])
		expect(lifegame.get_cell_status(0)).to eq("D")
	end
	it "セルの状態をマス目の形式で返す" do
		lifegame = Lifegame.new([0,0,0,0,0,0,0,0,0])
		expect(lifegame.show()).to eq([["D","D","D"],["D","D","D"],["D","D","D"]])
		lifegame = Lifegame.new([1,0,0,0,0,0,0,0,0])
		expect(lifegame.show()).to eq([["A","D","D"],["D","D","D"],["D","D","D"]])
	end
	it "死んでいるセルに隣接する生きたセルがちょうど3つあれば、次の世代が誕生する" do
		lifegame = Lifegame.new([1,1,0,1,0,0,0,0,0])
		expect(lifegame.dead_or_alive(4)).to eq(1)
	end
	it "生きているセルに隣接する生きたセルが2つか3つならば、次の世代でも生存する。" do
		lifegame = Lifegame.new([1,1,0,1,0,0,0,0,0])
		expect(lifegame.dead_or_alive(1)).to eq(1)
	end
	it "生きているセルに隣接する生きたセルが1つ以下ならば、過疎により死滅する。" do
		lifegame = Lifegame.new([1,0,0,1,0,0,0,0,0])
		expect(lifegame.dead_or_alive(3)).to eq(0)
	end
	it "生きているセルに隣接する生きたセルが4つ以上ならば、過密により死滅する。" do
		lifegame = Lifegame.new([1,1,1,1,1,1,0,0,0])
		expect(lifegame.dead_or_alive(4)).to eq(0)
	end
	it "0,1,3のセルが生きている状態で、次の世代に進むと0,1,3,4が生きている。" do
		lifegame = Lifegame.new([1,1,0,1,0,0,0,0,0])
		expect(lifegame.show()).to eq([["A","A","D"],["A","D","D"],["D","D","D"]])
		lifegame.next
		expect(lifegame.show()).to eq([["A","A","D"],["A","A","D"],["D","D","D"]])
	end
end