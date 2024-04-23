/**
 * GoodsDto
 */	

public class GoodsDto {
	
	int id;
	int width;
	int length;
	int weight;
	int height;
	int userId;
	int areaId;
	
	public GoodsDto(int id, int width, int length, int height, int weight, int userId, int areaId) {
		this.id = id;
		this.width = width;
		this.length = length;
		this.height = height;
		this.weight = weight;
		this.userId = userId;
		this.areaId = areaId;
	}	
	
	@Override
	public String toString() {
		return "GoodsDto [id=" + id + ", width=" + width + ", length=" + length + ", height="
				+ height + ", weight=" + weight + ", userId=" + userId + ", aearId=" + areaId + "]";
	}
    

}