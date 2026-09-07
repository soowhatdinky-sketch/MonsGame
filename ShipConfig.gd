extends Node
; MonsGame - Godot 4.7 project configuration
; Cleaned and consolidated configuration.

config_version=5

[application]

config/name="MonsGame"
config/description="MonsGame - 3D sci-fi exploration and adventure."
run/main_scene="uid://bkbv8t2yunnew"
config/features=PackedStringArray("4.7", "Forward Plus")
run/low_processor_mode=true
run/load_shell_environment=true
boot_splash/show_image=false
boot_splash/image="uid://bbccog1sy3xhv"

[animation]

compatibility/default_parent_skeleton_in_mesh_instance_3d=true

[autoload]

GdPAIAutoload="*uid://ol4q4tu0vtwo"
BootSplashPlus="*uid://bmmmyvf7c1rya"

[editor_plugins]

enabled=PackedStringArray(
"res://addons/DeeplinkPlugin/plugin.cfg",
"res://addons/GDQuest_GDScript_formatter/plugin.cfg",
"res://addons/GdPlanningAI/plugin.cfg",
"res://addons/boot_splash_plus/plugin.cfg",
"res://addons/gdscript2all/plugin.cfg"
)

[filesystem]

import/fbx2gltf/enabled.android=true
import/fbx2gltf/enabled.web=true
import/blender/enabled.android=true
import/blender/enabled.web=true

[importer_defaults]

texture={
"detect_3d/compress_to": 0
}

animation_library={
&"nodes/root_scale": 1000.0
}

[input_devices]

joypads/ignore_joypad_on_unfocused_application=true

[memory]

limits/message_queue/max_size_mb=140

[rendering]

textures/canvas_textures/default_texture_filter=2
textures/canvas_textures/default_texture_repeat=1
textures/vram_compression/import_s3tc_bptc=true
lights_and_shadows/use_physical_light_units=true
textures/default_filters/anisotropic_filtering_level=4
viewport/transparent_background=true
textures/default_filters/use_nearest_mipmap_filter=false

[threading]

worker_pool/max_threads=4
