// CorrArray.cpp: implementation of the CCorrArray class.
//
// by Oleg Krichevsky, Ben-Gurion University, Dec. 2003
// okrichev@bgu.ac.il
//////////////////////////////////////////////////////////////////////

#include "CorrArray.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
template <class CorrType, int MAXSIZE>
CCorrArray<CorrType, MAXSIZE>::CCorrArray()
:mSize(0),
TotalLength(0)
{   }

template <class CorrType, int MAXSIZE>
CCorrArray<CorrType, MAXSIZE>::CCorrArray(int NumOfCorrelators, int DoublingSize)
:mSize(0),
TotalLength(0)
{

	long SamplingTime = 1;

	//First correlator is twice the length
	Add(CorrType(SamplingTime, 2 * DoublingSize, 0));

	double LastTime = (2*DoublingSize - 1) * SamplingTime;

	for (int i = 1; i < NumOfCorrelators; i++)
	{
		SamplingTime = SamplingTime * 2;
		Add(CorrType(SamplingTime, DoublingSize, LastTime));
		LastTime += (DoublingSize - 1) * SamplingTime;
		//LastTime += DoublingSize * SamplingTime;
	}
}

template <class CorrType, int MAXSIZE>
CCorrArray<CorrType, MAXSIZE>::~CCorrArray()
{   }

//BOOL
template <class CorrType, int MAXSIZE>
int CCorrArray<CorrType, MAXSIZE>::Add(const CorrType& c)
{
  x[mSize] = c;
  TotalLength += x[mSize].GetNumOfAccumulators();
  mSize++;
  return 0; //TRUE;
}

//BOOL
template <class CorrType, int MAXSIZE>
CCorrArray<CorrType, MAXSIZE>::InsertAt(const CorrType& c, int idx)
{
  if (mSize >= ARRAY_MAXSIZE)  
    return 1; //FALSE;          // full
  if (idx < 0 || idx > mSize) 
    return 1; //FALSE;          // illegal idx
  for (int i = mSize-1; i >= idx; i--) 
    x[i+1] = x[i];         // shift up

  x[idx] = c;              // insert
  mSize++;
  return 0; //TRUE;
}

//BOOL
template <class CorrType, int MAXSIZE>
int CCorrArray<CorrType, MAXSIZE>::RemoveAt(int idx)
{
  if (idx < 0 || idx >= mSize)
    return 1; //FALSE;    // illegal idx
  for (int i = idx; i < mSize-1; i++)
    x[i] = x[i+1];
  mSize--;
  return 0; //TRUE;
}

template <class CorrType, int MAXSIZE>
CorrType CCorrArray<CorrType, MAXSIZE>::GetAt(int idx)
{
   return x[idx];
}

template <class CorrType, int MAXSIZE>
int CCorrArray<CorrType, MAXSIZE>::GetSize() const
{
  return mSize;
}

template <class CorrType, int MAXSIZE>
void CCorrArray<CorrType, MAXSIZE>::ProcessEntry(EntryType Entry)
{
	for (int i = 0; i < mSize; i++)
		x[i].ProcessEntry(Entry);

}

template <class CorrType, int MAXSIZE>
void CCorrArray<CorrType, MAXSIZE>::GetAccumulators(double *corr)
{
	int CumLen = 0; 
	for (int i = 0; i < mSize; i++)
	{
		x[i].GetAccumulators(corr + CumLen);
		x[i].GetLags(corr+CumLen+TotalLength);
		x[i].GetWeights(corr+CumLen+2*TotalLength);
		CumLen += x[i].GetNumOfAccumulators();
	}
}
