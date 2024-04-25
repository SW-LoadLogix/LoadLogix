/**
 * Goods
 */	

public class GoodsDto {
	
	int id;
	int width;
	int length;
	int weight;
	int height;
	int userId;
	int areaId;
	
	public GoodsDto() {}
	
	public GoodsDto(int id, int width, int length, int height, int weight, int userId, int areaId) {
		this.id = id;
		this.width = width;
		this.length = length;
		this.height = height;
		this.weight = weight;
		this.userId = userId;
		this.areaId = areaId;
	}	
	
	public int getId() {
		return id;
	}
	public int getWidth() {
		return width;
	}
	public int getHeight() {
		return height;
	}
	public int getLength() {
		return length;
	}
	public int getWeight() {
		return weight;
	}
	public int getUserId() {
		return userId;
	}
	public int getAreaId() {
		return areaId;
	}
	
	
	@Override
	public String toString() {
		return "GoodsDto [id=" + id + ", width=" + width + ", length=" + length + ", height="
				+ height + ", weight=" + weight + ", userId=" + userId + ", aearId=" + areaId + "]";
	}
    

}