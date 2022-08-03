//
//  PublicToiletCell.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import CoreLocation
import SwiftUI

struct PublicToiletCell: View {
    var viewModel: PublicToiletCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                fullAddress

                Spacer()

                openMapButton
            }

            openingHour

            prmAccess

            distanceIfPermitted

            Divider()
        }
    }

    var fullAddress: some View {
        imageText(imageName: "map", text: viewModel.fullAddress)
            .foregroundColor(.black)
    }

    var openingHour: some View {
        imageText(imageName: "clock", text: viewModel.openingHour)
            .foregroundColor(.black)
    }

    var prmAccess: some View {
        imageText(imageName: viewModel.isPrmAccess ? "checkmark" : "xmark",
                  text: viewModel.prmAccess)
        .padding(.vertical)
        .foregroundColor(viewModel.isPrmAccess ? .green : .red)
    }

    private func imageText(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 20, weight: .bold))

            Text(text)
                .lineLimit(2)
        }
    }

    @ViewBuilder
    var distanceIfPermitted: some View {
        if let _ = viewModel.coordinate {
            Text(viewModel.distance)
                .foregroundColor(.black)
        }
    }

    @ViewBuilder
    var openMapButton: some View {
        if viewModel.model.geometry.coordinates.count == 2 {
            Button {
                viewModel.openMap()
            } label: {
                Image(systemName: "location.fill")
            }
        }
    }
}

struct PublicToiletCell_Previews: PreviewProvider {
    static var previews: some View {
        PublicToiletCell(viewModel: .mock)
    }
}
