return function(pn, element)
	return {
		x = TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..element.."X"] or 0,
        y = TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..element.."Y"] or 0,
        zoom = tonumber(string.match(TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..element.."Zoom"], '%d+')) / 100 or 1,
        alpha = tonumber(string.match(TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..element.."Alpha"], '%d+')) / 100 or 1,
	}
end