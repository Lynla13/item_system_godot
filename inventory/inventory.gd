extends PanelContainer

const Slot = preload("res://inventory/slot.tscn")
@onready var item_gird = $MarginContainer/ItemGird

func set_inventory_data (inventory_data : InventoryData) -> void:
	inventory_data.inventory_update.connect (populate_item_gird)
	populate_item_gird(inventory_data)
 
func clear_inventory_data (inventory_data : InventoryData) -> void:
	inventory_data.inventory_update.disconnect (populate_item_gird)

func populate_item_gird (inventory_data : InventoryData) -> void:
	for child in item_gird.get_children():
		child.queue_free()
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_gird.add_child(slot)
		
		slot.slot_clicked.connect (inventory_data.on_slot_clicked)
		if slot_data:
			slot.set_slot_data(slot_data)
