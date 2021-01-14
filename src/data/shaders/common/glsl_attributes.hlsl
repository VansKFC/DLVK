// Jesli edytujesz ten plik KONIECZNIE trzeba zsynchronizowac plik 
//
//
//   //ce6/main/src/engine/rWiiU/rWiiU_Attributes.h
//
//

#if defined(SHADER_PATH_OPENGL)

	#if defined(VERTEXSHADER)

        // There's only 16 attributes on WiiU

        #define GLSL_POSITION           0
        #define GLSL_BLENDWEIGHT        1
        #define GLSL_NORMAL             2
        #define GLSL_COLOR0             3
        #define GLSL_COLOR1             4
        #define GLSL_BLENDINDICES       7
        #define GLSL_TEXCOORD0          8
        #define GLSL_TEXCOORD1          9
        #define GLSL_TEXCOORD2          10
        #define GLSL_TEXCOORD3          11
        #define GLSL_TANGENT            14
        #define GLSL_BINORMAL           15
        #define GLSL_TEXCOORD4          5
        #define GLSL_TEXCOORD5          6
        #define GLSL_TEXCOORD6          12
        #define GLSL_TEXCOORD7          13
        #define GLSL_COLOR3             15

        #define GLSL_POSITION1          5
        #define GLSL_NORMAL1            6
        #define GLSL_TANGENT1           12
        #define GLSL_BLENDWEIGHT1       13
		
		
		// hlsl -> glsl input semantics mapping
		
		#define POSITION		GLSL_POSITION     
		#define POSITION0		GLSL_POSITION     
		
		#define POSITION1		GLSL_POSITION1     
		     
		#define BLENDWEIGHT   	GLSL_BLENDWEIGHT       
		#define BLENDWEIGHT0   	GLSL_BLENDWEIGHT       
		
		#define NORMAL        	GLSL_NORMAL            
		#define NORMAL0        	GLSL_NORMAL            
		#define COLOR        	GLSL_COLOR0            
		#define COLOR0        	GLSL_COLOR0            
		#define COLOR1        	GLSL_COLOR1            
		#define COLOR2        	GLSL_COLOR1            
		#define COLOR3        	GLSL_COLOR1            
		
		#define BLENDINDICES  	GLSL_BLENDINDICES      
		
		#define TEXCOORD0     	GLSL_TEXCOORD0         
		#define TEXCOORD1     	GLSL_TEXCOORD1         
		#define TEXCOORD2     	GLSL_TEXCOORD2         
		#define TEXCOORD3     	GLSL_TEXCOORD3         
		
		#define TANGENT       	GLSL_TANGENT           
		#define TANGENT0       	GLSL_TANGENT           
		#define BINORMAL      	GLSL_BINORMAL          
		#define BINORMAL0      	GLSL_BINORMAL          
				
		#define TEXCOORD4     	GLSL_TEXCOORD4         
		#define TEXCOORD5     	GLSL_TEXCOORD5         
		#define TEXCOORD6     	GLSL_TEXCOORD6         
		#define TEXCOORD7     	GLSL_TEXCOORD7         
				
		#define BLENDWEIGHT1  	GLSL_BLENDWEIGHT1      	
		
		
	#elif defined(PIXELSHADER)

		#define COLOR					0
		#define COLOR0					0
		#define COLOR1					1
		#define COLOR2					2
		#define COLOR3					3
		
	#endif

#endif
