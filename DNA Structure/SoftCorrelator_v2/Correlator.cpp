// Correlator.cpp: implementation of the CCorrelator class.
//
// by Oleg Krichevsky, Ben-Gurion University, Dec. 2003
// okrichev@bgu.ac.il
//////////////////////////////////////////////////////////////////////

#include "Correlator.h"
#include <math.h>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCorrelator::CCorrelator()
{
}


CCorrelator::CCorrelator(long Stime, int Nchannels, double startTime)
{
	smplTime = Stime;
	NumOfAccumulators = Nchannels;
	FirstDelayTime = startTime;
	Delay = FirstDelayTime/smplTime;
	NumOfChannels = NumOfAccumulators + Delay;
	maxdelay = FirstDelayTime + NumOfChannels * smplTime;
	counter = 0;
	countDown = smplTime;
	TotalCounts = 0;
	TotalSamplingTimes = 0;
 
	delayChannel = (double *)calloc( NumOfChannels, sizeof( double ) );
	accumulator = (double *)calloc( NumOfAccumulators, sizeof( double ) );
	lag = (double *)calloc( NumOfAccumulators, sizeof( double ) );

	SumZeroTimeCounts = (double *)calloc( NumOfAccumulators, sizeof( double ) );
	SumDelayedTimeCounts = (double *)calloc( NumOfAccumulators, sizeof( double ) );


	cursor = delayChannel;
	delayedCursor = delayChannel + Delay;

	LastDelayChannel = delayChannel + NumOfChannels -1;
	
	if ((delayChannel == NULL) || (accumulator == NULL) || (lag == NULL) || (SumZeroTimeCounts == NULL) || (SumDelayedTimeCounts == NULL))
	{
		//#ifdef _WIN32
			mexErrMsgTxt("Low memory! Cannot allocate arrays!");
	//	#else
			// cout << "Low memory! Cannot allocate arrays!";
	//	#endif
		
		free(delayChannel);
		free(accumulator);
		free(lag);
		free(SumZeroTimeCounts);
		free(SumDelayedTimeCounts);
		return;
	};

    // mexPrintf("Allocating correlators\n");
	
	for (double* tempDelayCh = delayChannel; tempDelayCh <= LastDelayChannel;)
		*tempDelayCh++ = 0;


	double* tempSZTC = SumZeroTimeCounts;
	double* tempSDTC = SumDelayedTimeCounts;
	for (double* tempAcc = accumulator; tempAcc < accumulator + NumOfAccumulators; )
	{
		*tempAcc++ =0;
		*tempSZTC++ = 0;
		*tempSDTC++ = 0;
	};


	double time = FirstDelayTime;
	for (double* temp = lag; temp < lag + NumOfAccumulators; )
	{
		*temp++ = time;
		time += smplTime;
	}

}

CCorrelator::~CCorrelator()
{
//		free(delayChannel);
//		free(accumulator);
//		mexPrintf("Destroying correlators\n");
}


void CCorrelator::GetCounterIn()
{
	if (cursor > delayChannel)
		cursor--;
	else cursor = LastDelayChannel;

	if (delayedCursor > delayChannel)
		delayedCursor--;
	else delayedCursor = LastDelayChannel;

	*cursor = counter;
	double* accumcursor = accumulator;
	double* tempSZTC = SumZeroTimeCounts;
	double* tempSDTC = SumDelayedTimeCounts;

	double* tempcursor;

	if (delayedCursor >= cursor)
	{
		for ( tempcursor = delayedCursor; tempcursor <= LastDelayChannel; tempcursor ++ )
		{
			*accumcursor += (*tempcursor) * counter;
			accumcursor ++;

			*tempSZTC += counter;
			tempSZTC ++;

			*tempSDTC += (*tempcursor);
			tempSDTC ++;

		};

		for (tempcursor = delayChannel; tempcursor < cursor; tempcursor ++ )
		{
			*accumcursor += (*tempcursor) * counter;
			accumcursor ++;

			*tempSZTC += counter;
			tempSZTC ++;

			*tempSDTC += (*tempcursor);
			tempSDTC ++;

		};
	} 
	else
	{
		for (double* tempcursor = delayedCursor; tempcursor < cursor; tempcursor ++ )
		{
			*accumcursor += (*tempcursor) * counter;
			accumcursor ++;

			*tempSZTC += counter;
			tempSZTC ++;

			*tempSDTC += (*tempcursor);
			tempSDTC ++;

		};
	}


	countDown = smplTime;
	TotalSamplingTimes ++;
	TotalCounts += counter;
	counter = 0;
}

void CCorrelator::ShiftChannelsByN(double Nshifts)
{
	for (int i=0; i < Nshifts; i++)
	{
		if (cursor  > delayChannel)
			cursor--;
		else
			cursor = LastDelayChannel;
		*cursor = 0;
		
		if (delayedCursor  > delayChannel)
			delayedCursor--;
		else
			delayedCursor = LastDelayChannel;
	};

	TotalSamplingTimes += Nshifts;
}



void CCorrelator::ProcessEntry(EntryType Entry)
{
	if (Entry < countDown)
	{
		countDown -= Entry;
		counter++;
	}
	else if (Entry == countDown)
	{
		counter++;
		GetCounterIn();
	}
	else   //Entry > countDown
	{
		Entry -= countDown;
		GetCounterIn();

		double Nshifts = floorf((Entry-1)/smplTime);
		if (Nshifts <= NumOfChannels)
		{
			ShiftChannelsByN(Nshifts);
			Entry -= Nshifts * smplTime;
			counter = 1;
			if (Entry == smplTime)
				GetCounterIn();
			else 
				countDown -= Entry;
		}
		else  // Nshifts > NumOfChannels
		{
			for (cursor = delayChannel; cursor <= LastDelayChannel;)
				*cursor++ = 0;
			
			cursor = delayChannel;
			delayedCursor = cursor + Delay;
			TotalSamplingTimes += Nshifts;
			Entry -= Nshifts * smplTime;
			
			if (Entry == smplTime)
			{
				*cursor = 1;
				if (FirstDelayTime < 1)
				{
					(*accumulator)++; //zeroth channel
					(*SumZeroTimeCounts)++;
					(*SumDelayedTimeCounts)++;
				};
				TotalSamplingTimes++;
				TotalCounts++;
			}
			else
			{
				counter = 1;
				countDown -= Entry;
			}
			
		}
	}
}   

void CCorrelator::GetAccumulators(double *accout)
{
	
	double accumTime = TotalSamplingTimes - Delay;
	//long sqTime = smplTime * smplTime;
	double avCountsSq = TotalCounts / TotalSamplingTimes;
	avCountsSq = avCountsSq * avCountsSq;

	double* tempSZTC = SumZeroTimeCounts;
	double* tempSDTC = SumDelayedTimeCounts;

	for (double* temp = accumulator; (temp < (accumulator + NumOfAccumulators)); )
	{
		*accout++ = *temp++/(avCountsSq*accumTime--) - 1;
	//	*accout++ = (*temp++)*(accumTime--)/((*tempSZTC++)*(*tempSDTC++)) - 1;
	//	*accout++ = (*temp++)/((*tempSZTC++)*(*tempSDTC++)) - 1;

	}	
	
}

int CCorrelator::GetNumOfAccumulators()
{
	return NumOfAccumulators;
}

void CCorrelator::GetLags(double *lagOut)
{
	for (double* temp = lag; (temp < (lag + NumOfAccumulators)); )
		*lagOut++ = *temp++;

}

void CCorrelator::GetWeights(double *WeightsOut)
{
	double StartingWeight = TotalSamplingTimes - Delay;
	for (int i=0; i < NumOfAccumulators; i++)
		*WeightsOut++ = StartingWeight--;
}
