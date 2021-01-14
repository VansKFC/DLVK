#if defined(VERTEXSHADER)	

	#if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON)
		int iInstanceNumber = InstanceNumber(INPUT_STRUCT_NAME_DOT VertexIndex);
		int iBaseVertexIndex = BaseVertexIndex(INPUT_STRUCT_NAME_DOT VertexIndex, iInstanceNumber);	

		#if defined (POSITION_TYPE)
			POSITION_TYPE POSITION_NAME = Position_MS(iBaseVertexIndex);        
		#endif
	    
		#if defined (POSITION0_TYPE)
			POSITION0_TYPE POSITION0_NAME = Position_MS(iBaseVertexIndex);            
		#endif     
	    
	    
		#if defined (COLOR_TYPE)
			COLOR_TYPE COLOR_NAME = Color_0(iBaseVertexIndex);
		#endif      
	    
		#if defined (COLOR0_TYPE)
			COLOR0_TYPE COLOR0_NAME = Color_0(iBaseVertexIndex);
		#endif
	    
		#if defined (TEXCOORD_TYPE)
			TEXCOORD_TYPE TEXCOORD_NAME = Texcoord_0(iBaseVertexIndex);            
		#endif
	    
		#if defined (TEXCOORD0_TYPE)
			TEXCOORD0_TYPE TEXCOORD0_NAME = Texcoord_0(iBaseVertexIndex);            
		#endif
	    
		#if defined (TEXCOORD1_TYPE)
			TEXCOORD1_TYPE TEXCOORD1_NAME = Texcoord_1(iBaseVertexIndex);            
		#endif
	    
		#if defined (TEXCOORD2_TYPE)
			TEXCOORD2_TYPE TEXCOORD2_NAME = Texcoord_2(iBaseVertexIndex);            
		#endif             
	    
		#if defined (TEXCOORD3_TYPE)
			TEXCOORD3_TYPE TEXCOORD3_NAME = Texcoord_3(iBaseVertexIndex);            
		#endif    
	    
		#if defined (NORMAL_TYPE)
			NORMAL_TYPE NORMAL_NAME = Normal_MS(iBaseVertexIndex);        
		#endif
	    
		#if defined (NORMAL0_TYPE)
			NORMAL0_TYPE NORMAL0_NAME = Normal_MS(iBaseVertexIndex);            
		#endif
	    
		#if defined (TANGENT_TYPE)
			TANGENT_TYPE TANGENT_NAME = Tangent_MS(iBaseVertexIndex);        
		#endif
	    
		#if defined (TANGENT0_TYPE)
			TANGENT0_TYPE TANGENT0_NAME = Tangent_MS(iBaseVertexIndex);            
		#endif		
		
		#if defined (BINORMAL_TYPE)
			BINORMAL_TYPE BINORMAL_NAME = Binormal_MS(iBaseVertexIndex);        
		#endif
	    
		#if defined (BINORMAL0_TYPE)
			BINORMAL0_TYPE BINORMAL0_NAME = Binormal_MS(iBaseVertexIndex);        
		#endif		
	           
	#else

		#if defined (POSITION_TYPE)
			POSITION_TYPE POSITION_NAME = INPUT_STRUCT_NAME_DOT POSITION_NAME;    
		#endif
	    
		#if defined (POSITION0_TYPE)
			POSITION0_TYPE POSITION0_NAME = INPUT_STRUCT_NAME_DOT POSITION0_NAME;            
		#endif       
	    
		#if defined (COLOR_TYPE)
			COLOR_TYPE COLOR_NAME = INPUT_STRUCT_NAME_DOT COLOR_NAME;
		#endif      
	    
		#if defined (COLOR0_TYPE)
			COLOR0_TYPE COLOR0_NAME = INPUT_STRUCT_NAME_DOT COLOR0_NAME;
		#endif

		#if defined (TEXCOORD_TYPE)
			TEXCOORD_TYPE TEXCOORD_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD_NAME;       
		#endif
	    
		#if defined (TEXCOORD0_TYPE)
			TEXCOORD0_TYPE TEXCOORD0_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD0_NAME;            
		#endif
	    
		#if defined (TEXCOORD1_TYPE)
			TEXCOORD1_TYPE TEXCOORD1_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD1_NAME;            
		#endif
	    
		#if defined (TEXCOORD2_TYPE)
			TEXCOORD2_TYPE TEXCOORD2_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD2_NAME;            
		#endif             
	    
		#if defined (TEXCOORD3_TYPE)
			TEXCOORD3_TYPE TEXCOORD3_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD3_NAME;            
		#endif
	    
		#if defined (NORMAL_TYPE)
			NORMAL_TYPE NORMAL_NAME = INPUT_STRUCT_NAME_DOT NORMAL_NAME;        
		#endif
	    
		#if defined (NORMAL0_TYPE)
			NORMAL0_TYPE NORMAL0_NAME = INPUT_STRUCT_NAME_DOT NORMAL0_NAME;            
		#endif
	    
		#if defined (TANGENT_TYPE)
			TANGENT_TYPE TANGENT_NAME = INPUT_STRUCT_NAME_DOT TANGENT_NAME;        
		#endif
	    
		#if defined (TANGENT0_TYPE)
			TANGENT0_TYPE TANGENT0_NAME = INPUT_STRUCT_NAME_DOT TANGENT0_NAME;            
		#endif   
		
		#if defined (BINORMAL_TYPE)
			BINORMAL_TYPE BINORMAL_NAME = INPUT_STRUCT_NAME_DOT BINORMAL_NAME;        
		#endif
	    
		#if defined (BINORMAL0_TYPE)
			BINORMAL0_TYPE BINORMAL0_NAME = INPUT_STRUCT_NAME_DOT BINORMAL0_NAME;        
		#endif	    
	    
		#if defined (POSITION1_TYPE)
			POSITION1_TYPE POSITION1_NAME = INPUT_STRUCT_NAME_DOT POSITION1_NAME;            
		#endif
	    
		#if defined (BLENDWEIGHT_TYPE)
			BLENDWEIGHT_TYPE BLENDWEIGHT_NAME = INPUT_STRUCT_NAME_DOT BLENDWEIGHT_NAME;            
		#endif     

		#if defined (BLENDWEIGHT1_TYPE)
			BLENDWEIGHT1_TYPE BLENDWEIGHT1_NAME = INPUT_STRUCT_NAME_DOT BLENDWEIGHT1_NAME;            
		#endif        
	  
	    
		#if defined (COLOR1_TYPE)
			COLOR1_TYPE COLOR1_NAME = INPUT_STRUCT_NAME_DOT COLOR1_NAME;            
		#endif
	    
		#if defined (COLO2R_TYPE)
			COLOR2_TYPE COLOR2_NAME = INPUT_STRUCT_NAME_DOT COLOR2_NAME;
		#endif
	    
		#if defined (COLOR3_TYPE)
			COLOR3_TYPE COLOR3_NAME = INPUT_STRUCT_NAME_DOT COLOR3_NAME;        
		#endif
	    
		#if defined (BLENDINDICES_TYPE)
			BLENDINDICES_TYPE BLENDINDICES_NAME = INPUT_STRUCT_NAME_DOT BLENDINDICES_NAME;  
		#endif     
	    
		#if defined (INDEX_TYPE)
			INDEX_TYPE INDEX_NAME = INPUT_STRUCT_NAME_DOT INDEX_NAME;     
		#endif    
	 
		#if defined (NORMAL1_TYPE)
			NORMAL1_TYPE NORMAL1_NAME = INPUT_STRUCT_NAME_DOT NORMAL1_NAME;      
		#endif    
	 
		#if defined (TANGENT1_TYPE)
			TANGENT1_TYPE TANGENT1_NAME = INPUT_STRUCT_NAME_DOT TANGENT1_NAME;    
		#endif  
	    
		#if defined (TEXCOORD4_TYPE)
			TEXCOORD4_TYPE TEXCOORD4_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD4_NAME;     
		#endif             
	    
		#if defined (TEXCOORD5_TYPE)
			TEXCOORD5_TYPE TEXCOORD5_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD5_NAME;         
		#endif             
	    
		#if defined (TEXCOORD6_TYPE)
			TEXCOORD6_TYPE TEXCOORD6_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD6_NAME;        
		#endif             
	    
		#if defined (TEXCOORD7_TYPE)
			TEXCOORD7_TYPE TEXCOORD7_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD7_NAME;         
		#endif             
	    
		#if defined (TEXCOORD8_TYPE)
			TEXCOORD8_TYPE TEXCOORD8_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD8_NAME;       
		#endif             
	    
		#if defined (TEXCOORD9_TYPE)
			TEXCOORD9_TYPE TEXCOORD9_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD9_NAME;   
		#endif             
	    
		#if defined (TEXCOORD10_TYPE)
			TEXCOORD10_TYPE TEXCOORD10_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD10_NAME;
		#endif             
	    
		#if defined (TEXCOORD11_TYPE)
			TEXCOORD11_TYPE TEXCOORD11_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD11_NAME;     
		#endif             
	    
		#if defined (TEXCOORD12_TYPE)
			TEXCOORD12_TYPE TEXCOORD12_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD12_NAME;    
		#endif             
	    
		#if defined (TEXCOORD13_TYPE)
			TEXCOORD13_TYPE TEXCOORD13_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD13_NAME;
		#endif             
	    
		#if defined (TEXCOORD14_TYPE)
			TEXCOORD14_TYPE TEXCOORD14_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD14_NAME;      
		#endif             
	    
		#if defined (TEXCOORD15_TYPE)
			TEXCOORD15_TYPE TEXCOORD15_NAME = INPUT_STRUCT_NAME_DOT TEXCOORD15_NAME;
		#endif                  
	    
	#endif
	        
	        
	float4 MODEL_XFORM_4x3[3];
	
	#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
		float4 MODEL_XFORM_4x3_PREV[3];
	#endif	
	
	
	#if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON)

		#if defined (COLOR_USER_TYPE)
			COLOR_USER_TYPE COLOR_USER_NAME = ColorUser_0(iInstanceNumber);
		#endif       
	    
		MODEL_XFORM_4x3[0] = ModelXForm_Row0(iInstanceNumber);
		MODEL_XFORM_4x3[1] = ModelXForm_Row1(iInstanceNumber);
		MODEL_XFORM_4x3[2] = ModelXForm_Row2(iInstanceNumber);

		#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
			MODEL_XFORM_4x3_PREV[0] = MODEL_XFORM_4x3[0];
			MODEL_XFORM_4x3_PREV[1] = MODEL_XFORM_4x3[1];
			MODEL_XFORM_4x3_PREV[2] = MODEL_XFORM_4x3[2];
		#endif	
		
	#elif defined(INSTANCING_SM30_ON)

		#if defined (COLOR_USER_TYPE)
			COLOR_USER_TYPE COLOR_USER_NAME = INPUT_STRUCT_NAME_DOT v_const_0;
		#endif
		
		#if defined (REQ_WORLD_SPACE)
			MODEL_XFORM_4x3[0] = float4(1.0, 0.0, 0.0, 0.0);
			MODEL_XFORM_4x3[1] = float4(0.0, 1.0, 0.0, 0.0);
			MODEL_XFORM_4x3[2] = float4(0.0, 0.0, 1.0, 0.0);
		#else	    
			MODEL_XFORM_4x3[0] = INPUT_STRUCT_NAME_DOT MODEL_XFORM_I_R0;
			MODEL_XFORM_4x3[1] = INPUT_STRUCT_NAME_DOT MODEL_XFORM_I_R1;
			MODEL_XFORM_4x3[2] = INPUT_STRUCT_NAME_DOT MODEL_XFORM_I_R2;
		#endif
		
		#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
			MODEL_XFORM_4x3_PREV[0] = MODEL_XFORM_4x3[0];
			MODEL_XFORM_4x3_PREV[1] = MODEL_XFORM_4x3[1];
			MODEL_XFORM_4x3_PREV[2] = MODEL_XFORM_4x3[2];
		#endif
		
	#elif defined(INSTANCING_DIP_ON)

		 #if defined (COLOR_USER_TYPE)
			COLOR_USER_TYPE COLOR_USER_NAME = INSTANCE_DATA.COLOR0;
		#endif
		
		#if defined (REQ_WORLD_SPACE)
			MODEL_XFORM_4x3[0] = float4(1.0, 0.0, 0.0, 0.0);
			MODEL_XFORM_4x3[1] = float4(0.0, 1.0, 0.0, 0.0);
			MODEL_XFORM_4x3[2] = float4(0.0, 0.0, 1.0, 0.0);
		#else	    
			MODEL_XFORM_4x3[0] = INSTANCE_DATA.MODEL_XFORM[0];
			MODEL_XFORM_4x3[1] = INSTANCE_DATA.MODEL_XFORM[1];
			MODEL_XFORM_4x3[2] = INSTANCE_DATA.MODEL_XFORM[2];      			
		#endif
		
		#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
			MODEL_XFORM_4x3_PREV[0] = MODEL_XFORM_4x3[0];
			MODEL_XFORM_4x3_PREV[1] = MODEL_XFORM_4x3[1];
			MODEL_XFORM_4x3_PREV[2] = MODEL_XFORM_4x3[2];
		#endif
		
	#elif defined(REQ_SKINNING_ONE_BONE) || defined(REQ_SKINNING)		
	
		#if defined (COLOR_USER_TYPE)
			COLOR_USER_TYPE COLOR_USER_NAME = CONST_0;
		#endif  
	
        #if defined(REQ_SKINNING_ONE_BONE)
	       VertexBlend_XFORM(BLENDINDICES_NAME .x, MODEL_XFORM_4x3[0], MODEL_XFORM_4x3[1], MODEL_XFORM_4x3[2]);

			#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
				VertexBlend_XFORM_prev(BLENDINDICES_NAME .x, MODEL_XFORM_4x3_PREV[0], MODEL_XFORM_4x3_PREV[1], MODEL_XFORM_4x3_PREV[2]);
			#endif		   
		   
        #elif defined(REQ_SKINNING)           
	       VertexBlend_XFORM(BLENDWEIGHT_NAME, BLENDINDICES_NAME, MODEL_XFORM_4x3[0], MODEL_XFORM_4x3[1], MODEL_XFORM_4x3[2]);
		   
			#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
				VertexBlend_XFORM_prev(BLENDWEIGHT_NAME, BLENDINDICES_NAME, MODEL_XFORM_4x3_PREV[0], MODEL_XFORM_4x3_PREV[1], MODEL_XFORM_4x3_PREV[2]);
			#endif
			
        #endif 		         
	      
	#else
		#if defined (COLOR_USER_TYPE)
			COLOR_USER_TYPE COLOR_USER_NAME = CONST_0;
		#endif  
		
		#if defined (REQ_WORLD_SPACE)
			MODEL_XFORM_4x3[0] = float4(1.0, 0.0, 0.0, 0.0);
			MODEL_XFORM_4x3[1] = float4(0.0, 1.0, 0.0, 0.0);
			MODEL_XFORM_4x3[2] = float4(0.0, 0.0, 1.0, 0.0);
		#else	    
			MODEL_XFORM_4x3[0] = MODEL_XFORM[0];
			MODEL_XFORM_4x3[1] = MODEL_XFORM[1];
			MODEL_XFORM_4x3[2] = MODEL_XFORM[2];
			
			#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
				MODEL_XFORM_4x3_PREV[0] = PREV_MODEL_XFORM[0];
				MODEL_XFORM_4x3_PREV[1] = PREV_MODEL_XFORM[1];
				MODEL_XFORM_4x3_PREV[2] = PREV_MODEL_XFORM[2];
			#endif
		#endif
	#endif
	
	#if defined(REQ_MORPH_TARGETS)
		#if defined(SHADER_PATH_OPENGL)
			#if defined(POSITION_NAME)
				GetMorphedVertexDelta(POSITION_NAME .xyz, gl_VertexID - GL_BaseVertex);		
			#endif
			
			#if defined(POSITION0_NAME)
				GetMorphedVertexDelta(POSITION0_NAME .xyz, gl_VertexID - GL_BaseVertex);				
			#endif      
		#else
			#if defined(POSITION_NAME)
				GetMorphedVertexDelta(POSITION_NAME .xyz, I_MORPH_INDEX);
			#endif
			
			#if defined(POSITION0_NAME)
				GetMorphedVertexDelta(POSITION0_NAME .xyz, I_MORPH_INDEX);
			#endif   		
		#endif
    #endif


#endif


