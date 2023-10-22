#include "CpuErosion.hpp"

CpuErosion::CpuErosion(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

CpuErosion::~CpuErosion()  
{
}



// void cpu_erosion8_v(
// 	long taille)	 E : Taille du noyau
// {
// 	long demitail;
// 	long nbempan,n,deb,fin,derfinplusun;
// 	long i,ix,iy,ififo;
// 	long pos_i;
// 	long indice,indice_max;
// 	unsigned char fifo[TAILLE_NOYAU_MAX];
// 	unsigned char mini,nbm,val;
// 	char *pmem = NULL;

//     demitail = (taille>>1);
//     pmem = (PCHAR)m_baseLin + (xmin*m_xinc);
// 	for(ix=0;ix<m_nbColonne;ix++)
//     {
// 	    nbempan = m_Colonne[ix].NbEmpan;
//         if(nbempan>0)
//         {
// 		    derfinplusun = 0;
// 			for(n=0;n<nbempan;n++)
//             {
// 			    mini = COULMAX;
// 				ififo = 0;
// 				deb = m_Colonne[ix].TabDebut[n];
// 				fin = m_Colonne[ix].TabFin[n];
//                 indice = deb;
// 				indice_max = fin;
// 				pos_i = indice*m_yinc;
// 				mini = (unsigned char)*(pmem + pos_i);
// 				for(;ififo<demitail;ififo++)
//                 {
//                     fifo[ififo] = mini;
// 					for(;ififo<taille;ififo++)
//                     {
// 					    if((fifo[ififo]=(unsigned char)*(pmem + pos_i))<mini)
//                         {
// 						    mini = fifo[ififo];
									
// 							if(indice<indice_max)
//                             {
// 							    indice++;
// 								pos_i = indice*m_yinc;
//                             }
// 						}
// 								nbm = 0;
// 								for(i=0;i<taille;i++)
// 									if(fifo[i]==mini) nbm++;
								
// 								ififo = 0;
// 								for(iy=deb;iy<=fin;iy++){
// 									*(pmem + (iy*m_yinc)) = mini;
// 									val = (unsigned char)*(pmem + pos_i);
// 									if(val<mini){
// 										fifo[ififo] = val;
// 										mini = val;
// 										nbm = 1;
// 									}
// 									else{
// 										if(fifo[ififo]==mini)	nbm--;
// 										if(val==mini)					nbm++;
// 										fifo[ififo] = val;
// 										if(nbm==0){
// 											mini = COULMAX;
// 											for(i=0;i<taille;i++){
// 												if(fifo[i]<mini) mini=fifo[i];
// 											}
// 											nbm = 0;
// 											for(i=0;i<taille;i++){
// 												if(fifo[i]==mini) nbm++;
// 											} 
// 										} 
// 									} 
// 									ififo++;
// 									if(ififo==taille) ififo=0;
// 									if(indice<indice_max){
// 										indice++;
// 										pos_i = indice*m_yinc;
// 									}
// 								} // "for(iy=deb;iy<=fin;iy++)"
// 								derfinplusun = fin + 1;
// 							} // "for(n=0;n<nbempan;n++)"
// 						} // "if(nbempan>=0)"
// 						pmem = pmem + m_xinc;
// 					} // "for(ix=xmin;ix<=ixfin;ix++)"
// }

// void cpu_erosion8_h(unsigned char *image,
// 	int xSize,
// 	int ySize,
// 	long taille)
// {
// 	long demitail;
// 	long nbempan,n,deb,fin,derfinplusun;
// 	long i,ix,iy,ififo;
// 	long pos_i;
// 	long indice,indice_max;
// 	unsigned char fifo[TAILLE_NOYAU_MAX];
// 	unsigned char mini,nbm,val;
// 	unsigned char *pmem = NULL;

// 	demitail = (taille>>1);
		
// 	pmem = image + xSize;
// 	for(iy=0;iy<m_nbLigne;iy++)
// 	{
// 		nbempan = m_Ligne[iy].NbEmpan;
// 		if(nbempan>0)
// 		{
// 			derfinplusun = 0;
// 			for(n=0;n<nbempan;n++)
// 			{
// 				mini = 255;
// 				ififo = 0;
// 				deb = m_Ligne[iy].TabDebut[n];
// 				fin = m_Ligne[iy].TabFin[n];
// 				indice = deb;
// 				indice_max = fin;
// 				pos_i = indice;
// 				mini = (unsigned char)*(pmem + pos_i);
// 				for(;ififo<demitail;ififo++)
// 					fifo[ififo] = mini;

// 				for(;ififo<taille;ififo++)
// 				{
// 					if((fifo[ififo]=(unsigned char)*(pmem + pos_i))<mini)
// 						mini = fifo[ififo];
// 					if(indice<indice_max){
// 						indice++;
// 						pos_i = indice;
// 					}
// 				}
// 				nbm = 0;
// 				for(ififo=0;ififo<taille;ififo++)
// 				{
// 					if(fifo[ififo]==mini)
// 						nbm++;
// 				} 
// 				ififo=0;
// 				for(ix=deb;ix<=fin;ix++)
// 				{
// 					*(pmem + ix) = mini;
// 					val = (unsigned char)*(pmem + pos_i);
// 					if(val<mini)
// 					{
// 						fifo[ififo] = val;
// 						mini = val;
// 						nbm = 1;
// 					}
// 					else
// 					{
// 						if(fifo[ififo]==mini)
// 							nbm--;
// 						if(val==mini)
// 							nbm++;
// 						fifo[ififo] = val;
// 						if(nbm==0)
// 						{
// 							mini = 255;
// 							for(i=0;i<taille;i++)
// 							{
// 								if(fifo[i]<mini)
// 									mini=fifo[i];
// 							}
// 							nbm = 0;
// 							for(i=0;i<taille;i++)
// 							{
// 								if(fifo[i]==mini)
// 									nbm++;
// 							} 
// 						} 
// 					} 
// 					ififo++;
// 					if(ififo==taille)
// 						ififo=0;
// 					if(indice<indice_max)
// 					{
// 						indice++;
// 						pos_i = indice;
// 					}
// 				}
// 				derfinplusun = fin + 1;
// 			}
// 		}
// 		pmem = pmem + xSize;
// 	}
// }

// void cpu_erosion8(unsigned char *image,
// 	int xSize,
// 	int ySize,
// 	long taille)
// {
// 	// erosionv(taille, image);
// 	 cpu_erosion8_h(image, xSize, ySize, taille);
// }


double    CpuErosion::process8bits()
{
    // cpu_erosion8(image8bits, xSize, ySize, 3);
    return 0;
}


double    CpuErosion::process16bits()
{
    // cpu_binarise16(image16bits, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    return 0;
}

