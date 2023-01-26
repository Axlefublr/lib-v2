/*
	This library contains multiple sorting algorithms and array-related functions to test them out
	You'll see the Big O notation for every sorting algorithm: worst, average and best case
	What each of those means in the context of the sorting algorithm will likely not be explicitly explained

	Some sorting algorithms will have been tested in terms of real time taken to sort 100000 indexes
	Take the time coming from the tests with a huge rock of salt, it's there simply to have a rough comparison between sorting algorithms

	Terms:
	Rising array   -- every index matches its value
	Shuffled array -- a shuffled rising array (Fisher-Yates shuffle)
	Random array   -- array filled with random numbers. the range of each number starts at 1 and ends at the length of the array multiplied by 7 (check the preset parameter of variation in GenerateRandomArray())

	The time it takes to sort 100k indexes is measured by sorting *shuffled* arrays
*/

ArrToStr(arrayObj, delimiter := ", ") {
	str := ""
	for key, value in arrayObj {
		if key = arrayObj.Length {
			str .= value
			break
		}
		str .= value delimiter
	}
	return str
}
Array.Prototype.DefineProp("toString", {Call: ArrToStr})

GenerateRandomArray(indexes, variation := 7) {
	arrayObj := []
	Loop indexes {
		arrayObj.Push(Random(1, indexes * variation))
	}
	return arrayObj
}

GenerateRisingArray(indexes) {
	arrayObj := []
	i := 1
	Loop indexes {
		arrayObj.Push(i)
		i++
	}
	return arrayObj
}

GenerateShuffledArray(indexes) {
	risingArray := GenerateRisingArray(indexes)
	shuffledArray := FisherYatesShuffle(risingArray)
	return shuffledArray
}

FisherYatesShuffle(arrayObj) {
	shufflerIndex := 0
	while --shufflerIndex > -arrayObj.Length {
		randomIndex := Random(-arrayObj.Length, shufflerIndex)
		if arrayObj[randomIndex] = arrayObj[shufflerIndex]
			continue
		temp := arrayObj[shufflerIndex]
		arrayObj[shufflerIndex] := arrayObj[randomIndex]
		arrayObj[randomIndex] := temp
	}
	return arrayObj
}
Array.Prototype.DefineProp("FisherYatesShuffle", {Call: FisherYatesShuffle})

/*
	O(n^2) -- worst case
	O(n^2) -- average case
	O(n)   -- best case
	Sorts 100k indexes in: 1 hour 40 minutes
*/
BubbleSort(arrayObj) {
	finishedIndex := -1
	Loop arrayObj.Length - 1 {
		swaps := 0
		for key, value in arrayObj {
			if value = arrayObj[finishedIndex]
				break
			if value <= arrayObj[key + 1]
				continue

			firstComp := arrayObj[key]
			secondComp := arrayObj[key + 1]
			arrayObj[key] := secondComp
			arrayObj[key + 1] := firstComp
			swaps++
		}
		if !swaps
			break
		finishedIndex--
	}
	return arrayObj
}
Array.Prototype.DefineProp("BubbleSort", {Call: BubbleSort})

/*
	O(n^2) -- all cases
	Sorts 100k indexes in: 1 hour 3 minutes
*/
SelectionSort(arrayObj) {
	sortedIndex := 0
	Loop arrayObj.Length - 1 {
		sortedIndex++
		NewMinInts := 0

		for key, value in arrayObj {
			if key < sortedIndex
				continue
			if key = sortedIndex
				min := {key:key, value:value}
			else if min.value > value {
				min := {key:key, value:value}
				NewMinInts++
			}
		}

		if !NewMinInts
			continue

		temp := arrayObj[sortedIndex]
		arrayObj[sortedIndex] := min.value
		arrayObj[min.key] := temp
	}
	return arrayObj
}
Array.Prototype.DefineProp("SelectionSort", {Call: SelectionSort})

/*
	O(n^2) -- worst case
	O(n^2) -- average case
	O(n)   -- best case
	Sorts 100k indexes in: 40 minutes
*/
InsertionSort(arrayObj) {
	for key, value in arrayObj {
		if key = 1
			continue
		temp := value
		prevIndex := 0
		While key + prevIndex - 1 >= 1 && temp < arrayObj[key + prevIndex - 1] {
			arrayObj[key + prevIndex] := arrayObj[key + prevIndex - 1]
			prevIndex--
		}
		arrayObj[key + prevIndex] := temp
	}
	return arrayObj
}
Array.Prototype.DefineProp("InsertionSort", {Call: InsertionSort})

/*
	O(n logn) -- all cases
	Sorts 100k indexes in: 4 seconds
*/
MergeSort(arrayObj) {
	Merge(leftArray, rightArray, fullArrayLength) {
		leftArraySize := fullArrayLength // 2
		rightArraySize := fullArrayLength - leftArraySize
		fullArray := []
		l := 1, r := 1

		While l <= leftArraySize && r <= rightArraySize {
			if leftArray[l] < rightArray[r] {
				fullArray.Push(leftArray[l])
				l++
			}
			else if leftArray[l] >= rightArray[r] {
				fullArray.Push(rightArray[r])
				r++
			}
		}
		While l <= leftArraySize {
			fullArray.Push(leftArray[l])
			l++
		}
		While r <= rightArraySize {
			fullArray.Push(rightArray[r])
			r++
		}
		return fullArray
	}

	arrayLength := arrayObj.Length

	if arrayLength <= 1
		return arrayObj

	middle := arrayLength // 2
	leftArray := []
	rightArray := []

	i := 1
	While i <= arrayLength {
		if i <= middle
			leftArray.Push(arrayObj[i])
		else if i > middle
			rightArray.Push(arrayObj[i])
		i++
	}

	leftArray := MergeSort(leftArray)
	rightArray := MergeSort(rightArray)
	return Merge(leftArray, rightArray, arrayLength)
}
Array.Prototype.DefineProp("MergeSort", {Call: MergeSort})

/*
	O(n + k) -- all cases
	Where "k" is the highest integer in the array
	The more indexes you want to sort, the bigger "thread delay" will have to be
	This sorting algorithm is *not* practical, use it exclusively for fun!
*/
SleepSort(arrayObj, threadDelay := 30) {
	sortedArrayObj := []

	_PushIndex(passedValue) {
		Settimer(() => sortedArrayObj.Push(passedValue), -passedValue * threadDelay)
	}

	for key, value in arrayObj {
		_PushIndex(value)
	}

	While sortedArrayObj.Length != arrayObj.Length {
		;We're waiting for the sorted array to be filled since otherwise we immidiately return an empty array (settimers don't take up the thread while waiting, unlike sleep)
	}
	return sortedArrayObj
}
Array.Prototype.DefineProp("SleepSort", {Call: SleepSort})