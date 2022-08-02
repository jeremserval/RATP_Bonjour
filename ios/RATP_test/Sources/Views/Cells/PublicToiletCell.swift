//
//  PublicToiletCell.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import SwiftUI

struct PublicToiletCell: View {
    var viewModel: PublicToiletCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            fullAddress

            openingHour

            prmAccess

           // distanceIfPermitted
            Divider()
        }
    }

    var fullAddress: some View {
        Text(viewModel.fullAddress)
            .lineLimit(2)
            .foregroundColor(.black)
    }

    var openingHour: some View {
        Text(viewModel.openingHour)
            .foregroundColor(.black)
    }

    var prmAccess: some View {
        HStack {
            Image(systemName: viewModel.isPrmAccess ? "checkmark" : "xmark")
                .font(.system(size: 20, weight: .bold))
            Text(viewModel.prmAccess)
        }
        .padding(.vertical)
        .foregroundColor(viewModel.isPrmAccess ? .green : .red)

    }

    var distanceIfPermitted: some View {
        Text("distance")
            .foregroundColor(.black)
    }

}

struct PublicToiletCell_Previews: PreviewProvider {
    static var previews: some View {
        PublicToiletCell(viewModel: .mock)
    }
}
