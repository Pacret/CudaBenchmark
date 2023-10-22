#include "CpuSobel.hpp"

CpuSobel::CpuSobel(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

CpuSobel::~CpuSobel()  
{
}

void cpu_sobel8(
    unsigned char* image,
    int xSize,
    int ySize)
	// -------------------------------------------------------------------
	//	Filtre de Sobel sur Fenetre
	//	Recherche de contours horizontaux & verticaux
	//		-1	-2	-1				-1	0	+1
	//		0	0	0		puis	-2	0	+2
	//		+1	+2	+1				-1	0	+1
	// -------------------------------------------------------------------
	//	28/05/02	JPE : Creation
	//	09/04/03	JPE : version UNIQUE
	// -------------------------------------------------------------------
{
	long mgrisH = 0;
	long mgrisV = 0;
	long mgris = 0;
	long x=0,y=0;
	unsigned char *tabligneprec = NULL;
	unsigned char *tablignecour = NULL;
	unsigned char *adrtmp = NULL;
	unsigned char *adrLine = NULL;
	unsigned char *lpPix = NULL;

    long m_xg, m_yh, m_xd, m_yb; 
    m_xg = m_yh = 0;
    m_xd = xSize;
    m_yb = ySize;
    
    // Init des lignes :
	tabligneprec = new unsigned char[xSize];
	tablignecour = new unsigned char[xSize];
    
    adrLine = image + (m_yh*ySize);
    lpPix = adrLine + m_xg;
	for(x=m_xg;x<=m_xd;x++){
	    tabligneprec[x] = (unsigned char)*(lpPix);
		lpPix = lpPix + 1;
	}

    // les lignes constituant la fenetre ne sont pas prises en compte :
	m_xg++; m_yh++; m_xd--; m_yb--;
	// Parcours de la Fenetre :
	for(y=m_yh;y<m_yb;y++){
        // Ligne courante :
		m_xg--; m_xd++;
		lpPix = adrLine + m_xg;
		for(x=m_xg;x<m_xd;x++){
		    tablignecour[x] = (unsigned char)*(lpPix);
			lpPix = lpPix + 1;
		}
		m_xg++; m_xd--;
		// Parcours de la ligne courante :
		lpPix = adrLine + (m_xg);
		for(x=m_xg;x<m_xd;x++){

		    // Sobel Horizontal :
			mgrisH = 
			    (unsigned char)*(image + ((y+1)*ySize) + (x-1))
				+ (2*(unsigned char)*(image + ((y+1)*ySize) + x))
				+ (unsigned char)*(image + ((y+1)*ySize) + (x+1))
				- tabligneprec[x-1] - (2*tabligneprec[x]) - tabligneprec[x+1];
			// Sobel Vertical :
			mgrisV = 
			    tabligneprec[x+1] - tabligneprec[x-1]
				+ (2*tablignecour[x+1]) - (2*tablignecour[x-1])
				+ (unsigned char)*(image + ((y+1)*ySize) + (x+1))
				- (unsigned char)*(image + ((y+1)*ySize) + (x-1));
			// Sobel : Somme des Valeurs Absolues
			mgris = abs(mgrisH) + abs(mgrisV);
			// Test :
			if(mgris>SOBEL_GREY_VALUE)
                *lpPix = (unsigned char)SOBEL_GREY_VALUE;
			else
                *lpPix = (unsigned char)(mgris);
			lpPix = lpPix + 1;
        }
		// Ligne suivante :
		adrtmp = tabligneprec;
		tabligneprec = tablignecour;
		tablignecour = adrtmp;
		adrLine = adrLine + ySize;
	}
	// Liberation :
	if (tabligneprec!=NULL) delete[] tabligneprec;
	if (tablignecour!=NULL) delete[] tablignecour;
}

double    CpuSobel::process8bits()
{
    cpu_sobel8(image8bits, xSize, ySize);
    return 0;
}


void cpu_sobel16(
    short* image,
    int xSize,
    int ySize)
	// -------------------------------------------------------------------
	//	Filtre de Sobel sur Fenetre
	//	Recherche de contours horizontaux & verticaux
	//		-1	-2	-1				-1	0	+1
	//		0	0	0		puis	-2	0	+2
	//		+1	+2	+1				-1	0	+1
	// -------------------------------------------------------------------
	//	28/05/02	JPE : Creation
	//	09/04/03	JPE : version UNIQUE
	// -------------------------------------------------------------------
{
	long mgrisH = 0;
	long mgrisV = 0;
	long mgris = 0;
	long x=0,y=0;
	short *tabligneprec = NULL;
	short *tablignecour = NULL;
	short *adrtmp = NULL;
	short *adrLine = NULL;
	short *lpPix = NULL;

    long m_xg, m_yh, m_xd, m_yb; 
    m_xg = m_yh = 0;
    m_xd = xSize;
    m_yb = ySize;
    
    // Init des lignes :
	tabligneprec = new short[xSize];
	tablignecour = new short[xSize];
    
    adrLine = image + (m_yh*ySize);
    lpPix = adrLine + m_xg;
	for(x=m_xg;x<=m_xd;x++){
	    tabligneprec[x] = (short)*(lpPix);
		lpPix = lpPix + 1;
	}

    // les lignes constituant la fenetre ne sont pas prises en compte :
	m_xg++; m_yh++; m_xd--; m_yb--;
	// Parcours de la Fenetre :
	for(y=m_yh;y<m_yb;y++){
        // Ligne courante :
		m_xg--; m_xd++;
		lpPix = adrLine + m_xg;
		for(x=m_xg;x<=m_xd;x++){

		    tablignecour[x] = (short)*(lpPix);
			lpPix = lpPix + 1;
		}
		m_xg++; m_xd--;
		// Parcours de la ligne courante :
		lpPix = adrLine + (m_xg);
		for(x=m_xg;x<m_xd;x++){

            // std::cout << "process (" << x << ", " << y << ")" << std::endl; 
		    // Sobel Horizontal :
			mgrisH = 
			    (short)*(image + ((y+1)*ySize) + (x-1))
				+ (2*(short)*(image + ((y+1)*ySize) + x))
				+ (short)*(image + ((y+1)*ySize) + (x+1))
				- tabligneprec[x-1] - (2*tabligneprec[x]) - tabligneprec[x+1];
			// Sobel Vertical :
			mgrisV = 
			    tabligneprec[x+1] - tabligneprec[x-1]
				+ (2*tablignecour[x+1]) - (2*tablignecour[x-1])
				+ (short)*(image + ((y+1)*ySize) + (x+1))
				- (short)*(image + ((y+1)*ySize) + (x-1));
			// Sobel : Somme des Valeurs Absolues
			mgris = abs(mgrisH) + abs(mgrisV);
			// Test :
			if(mgris>100)
                *lpPix = 100;
			else
                *lpPix = (short)(mgris);
			lpPix = lpPix + 1;
        }
		// Ligne suivante :
		adrtmp = tabligneprec;
		tabligneprec = tablignecour;
		tablignecour = adrtmp;
		adrLine = adrLine + ySize;
	}
	// Liberation :
	if (tabligneprec!=NULL) delete[] tabligneprec;
	if (tablignecour!=NULL) delete[] tablignecour;
}

double    CpuSobel::process16bits()
{
    cpu_sobel16(image16bits, xSize, ySize);
    return 0;
}


